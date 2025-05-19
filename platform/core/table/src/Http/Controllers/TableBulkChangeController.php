<?php

namespace Botble\Table\Http\Controllers;

use Botble\Base\Facades\Form;
use Botble\Table\Http\Requests\BulkChangeRequest;
use Botble\Table\Http\Requests\SaveBulkChangeRequest;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Throwable;
use Botble\Ecommerce\Models\OrderProduct;

class TableBulkChangeController extends TableController
{
    public function index(BulkChangeRequest $request): array
    {
        $class = $request->input('class');

        if (! class_exists($class)) {
            return [];
        }

        $object = $this->tableBuilder->create($class);

        $data = $object->getValueInput(null, null, 'text');

        $key = $request->input('key');

        if (! $key) {
            return $data;
        }

        $column = Arr::get($object->getAllBulkChanges(), $key);
        if (empty($column)) {
            return $data;
        }

        if (isset($column['callback'])) {
            $callback = $column['callback'];

            if (is_callable($callback)) {
                $data = $object->getValueInput(
                    $column['title'],
                    null,
                    $column['type'],
                    $callback()
                );
            } elseif (method_exists($object, $callback)) {
                $data = $object->getValueInput(
                    $column['title'],
                    null,
                    $column['type'],
                    call_user_func([$object, $callback])
                );
            }
        } else {
            $data = $object->getValueInput($column['title'], null, $column['type'], Arr::get($column, 'choices', []));
        }

        if (! empty($column['title'])) {
            $labelClass = config('laravel-form-builder.label_class');
            if (Str::contains(Arr::get($column, 'validate'), 'required')) {
                $labelClass .= ' required';
            }

            $data['html'] = Form::label($column['title'], null, ['class' => $labelClass])->toHtml() . $data['html'];
        }

        return $data;
    }

    public function update(SaveBulkChangeRequest $request)
    {
        $ids = $request->input('ids');

        if (empty($ids)) {
            return $this
                ->httpResponse()
                ->setError()
                ->setMessage(trans('core/table::table.please_select_record'));
        }

        $inputKey = $request->input('key');
        $inputValue = $request->input('value');

        $class = $request->input('class');

        if (! class_exists($class)) {
            return $this
                ->httpResponse()->setError();
        }

        $object = $this->tableBuilder->create($class);

        $columns = $object->getAllBulkChanges();

        if (! empty($columns[$inputKey]['validate'])) {
            $validator = Validator::make($request->input(), [
                'value' => $columns[$inputKey]['validate'],
            ]);

            if ($validator->fails()) {
                return $this
                    ->httpResponse()
                    ->setError()
                    ->setMessage($validator->messages()->first());
            }
        }

        try {
            $object->saveBulkChanges($ids, $inputKey, $inputValue);
            // if($inputValue == 'trash' || $inputValue == 'cancelled') {
            //     $order_prod = OrderProduct::select('barcode')->whereIn('order_id', $ids)->leftJoin('ec_products', 'ec_order_product.product_id', '=', 'ec_products.id')->get();
            //     foreach ($order_prod as $key => $value) {
            //         // echo "<pre>";print_r($value->barcode);
            //         $url = "https://c21341-ifservice.cloudiax.com/api/ECommerce/StockStatus?itemCode=123456";
            //         // $url = "https://c21341-ifservice.cloudiax.com/api/ECommerce/StockStatus?itemCode=".$value->barcode;

            //         $ch = curl_init();

            //         curl_setopt($ch, CURLOPT_URL, $url);
            //         curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            //         // Set the request method to POST
            //         curl_setopt($ch, CURLOPT_POST, true);
            //         curl_setopt($ch, CURLOPT_HTTPHEADER, [
            //             "Accept: application/json",
            //             "Company: QAT", 
            //             "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiJhZG1pbiIsIkVtcElEIjoiMTAyNDgiLCJDb21wYW55IjoiIiwiV2hzQ29kZSI6IidDdXN0b20nLCdETV8wMScsJ0ZHXzAxJywnRk9DJywnSUNfVUFFJywnUE1fMDEnLCdTUF8wMDEnLCdTUF8wMDInLCdTUF8wMDMnLCdTUF8wMDQnLCdTUF8wMDUnLCdTUF8wMDYnLCdTUF8wMDcnLCdTUF8wMDgnLCdTUF8wMDknLCdTUF8wMTAnLCdTUF8wMTEnLCdTUF8wMTInLCdTUF8wMTMnLCdTUF8wMTQnLCcwMScsJ0NOMDAxXzAxJywnQ3VzdG9tJywnRE1fMDEnLCdGR18wMScsJ0ZHXzAyJywnRkdfMDMnLCdGT0MnLCdJQ18wMScsJ0lDX1VBRScsJ1BNXzAxJywnU1BfMDAxJywnU1BfMDAxXzEnLCdTUF8wMDInLCdTUF8wMDMnLCdTUF8wMDNfMScsJ1NQXzAwNCcsJ1NQXzAwNScsJ1NQXzAwNicsJ1NQXzAwNycsJ1NQXzAwOCcsJ1NQXzAwOScsJ1NQXzAxMCcsJ1NQXzAxMScsJ1NQXzAxMicsJ1NQXzAxMycsJ1NQXzAxNCcsJ1NQXzAxNScsJ1NQXzAxNicsJ1NQXzAxNycsJ1NQXzAxOScsJ1NQXzAyMCcsJ1NQXzAyMF8xJywnU1BfMDIxJywnU1BfMDIyJywnU1BfMDIzJywnU1BfMDI0JywnU1BfMDI1JywnU1BfMDI2JywnU1BfMDI3JywnU1BfMDI4JywnU1BfMDI4XzEnLCdTUF8wMjhfMicsJ1NQXzAyOScsJ1NQXzAzMCcsJ1NQXzAzMScsJ1ZOXzAwMScsJ0N1c3RvbScsJ0RNXzAxJywnRkdfMDEnLCdGT0MnLCdJQ19VQUUnLCdQTV8wMScsJ1NQXzAwMScsJ1NQXzAwMicsJ1NQXzAwMycsJ1NQXzAwNCcsJ1NQXzAwNScsJ1NQXzAwNicsJ1NQXzAwNycsJ1NQXzAwOCcsJzAxJywnQ3VzdG9tJywnRE1fMDEnLCdGR18wMScsJ0ZPQycsJ0lDXzAxJywnSUNfTW92JywnSUNfT0FQJywnSUNfVUFFJywnUE1fMDEnLCdTUF8wMDEnLCdTUF8wMDInLCdTUF8wMDMnLCdTUF8wMDQnLCdTUF8wMDUnLCdTUF8wMDYnLCdTUF8wMDcnLCdTUF8wMDgnLCdTUF8wMDknLCdTUF8wMTAnLCdTUF8wMTEnLCdTUF8wMTInLCdTUF8wMTMnLCdTUF8wMTQnLCdTUF8wMTUnLCdTUF8wMTYnLCdTUF8wMTcnLCdTUF8wMTgnLCdTUF8wMTknLCdTUF8wMjAnLCdTUF8wMjEnLCdTUF8wMjInLCdTUF8wMjMnLCdTUF8wMjQnLCdTUF8wMjUnLCdTUF8wMjYnLCdTUF8wMjcnLCdTUF8wMjgnLCdTUF8wMjknLCdTUF8wMzAnLCdTUF8wMzEnLCdTUF8wMzInLCdTUF8wMzMnLCdTUF8wMzQnLCdTUF8wMzUnLCdTUF8wMzYnLCdTUF8wMzcnLCdTUF8wMzgnLCdTUF8wMzknLCdTUF8wNDAnLCdTUF8wNDEnLCdTUF8wNDInLCdTUF8wNDMnLCdTUF8wNDQnLCdTUF8wNDUnLCdTUF8wNDYnLCdTUF8wNDcnLCdTUF8wNDgnLCdTUF8wNDknLCdTUF8wNTAnLCdTUF8wNTEnLCdTUF8wNTInLCdTUF8wNTMnLCdTUF8wNTQnLCdTUF8wNTUnLCdTUF8wNTYnLCdTUF8wNTcnLCdTUF8wNTgnLCdTUF8wNTknLCdTUF8wNjAnLCdTUF8wNjEnLCdUWVNfMDEnLCcwMScsJ0NOMDAxXzAxJywnQ04wMDJfMDEnLCdDTjAwM18wMScsJ0NOMDA0XzAxJywnQ04wMDVfMDEnLCdDTjAwNl8wMScsJ0N1c3RvbScsJ0RNXzAxJywnRkdfMDEnLCdGR18wMicsJ0ZPQycsJ0lDX09NTicsJ0lDX1RZUycsJ0lDX1VBRScsJ1BNXzAxJywnU01QXzAxJywnU1BfMDAxJywnU1BfMDAyJywnU1BfMDAzJywnU1BfMDA0JywnU1BfMDA1JywnU1BfMDA2JywnU1BfMDA3JywnU1BfMDA4JywnU1BfMDA5JywnU1BfMDEwJywnU1BfMDExJywnU1BfMDEyJywnU1BfMDEzJywnU1BfMDE1JywnU1BfMDE2JywnU1BfMDE3JywnU1BfMDE4JywnU1BfMDE5JywnU1BfMDIwJywnU1BfMDIxJywnU1BfMDIyJywnMDEnLCdBbWF6b24nLCdBVF8wMScsJ0JLXzAxJywnQlJBTkQnLCdDMDIwMjM1NicsJ0NOMDAxXzAxJywnQ04wMDJfMDEnLCdDTjAwM18wMScsJ0NOMDA0XzAxJywnQ04wMDVfMDEnLCdDTjAwNl8wMScsJ0NOMDA3XzAxJywnQ04wMDhfMDEnLCdDV19TTTAwMCcsJ0NXX1NNMDAxJywnQ1dfU00wMDInLCdDV19TTTAwMycsJ0NXX1NNMDA0JywnQ1dfU00wMDUnLCdDV19TTTAwNicsJ0NXX1NNMDA3JywnQ1dfU00wMDgnLCdDV19TTTAwOScsJ0NXX1NNMDEwJywnRE1fMDEnLCdETV8wMicsJ0RNXzAzJywnRE1fMDQnLCdETV8wNScsJ0RNXzA2JywnRUNfMDEnLCdGR18wMScsJ0ZPQycsJ0dGXzAxJywnSUNfQU1QJywnSUNfQkhSJywnSUNfS1NBJywnSUNfTW92JywnSUNfT01OJywnSUNfUUFUJywnSVQnLCdJVDAyJywnUEtfMDEnLCdQTV8wMScsJ1BNXzAyJywnUUNfMDEnLCdSJkQnLCdTS18wMScsJ1NMXzAxJywnU01QXzAxJywnU1BfMDAxJywnU1BfMDAyJywnU1BfMDAzJywnU1BfMDA0JywnU1BfMDA1JywnU1BfMDA2JywnU1BfMDA3JywnU1BfMDA4JywnU1BfMDA5JywnU1BfMDEwJywnU1BfMDExJywnU1BfMDEyJywnU1BfMDEzJywnU1BfMDE0JywnU1BfMDE1JywnU1BfMDE2JywnU1BfMDE3JywnU1BfMDE4JywnU1BfMDE5JywnU1BfMDIwJywnU1BfMDIxJywnU1BfMDIyJywnU1BfMDIzJywnU1BfMDI0JywnU1BfMDI1JywnU1BfMDI2JywnU1BfMDI3JywnU1BfMDI4JywnU1BfMDI5JywnU1BfMDMwJywnU1BfMDMxJywnU1BfMDMyJywnU1BfMDMyXzEnLCdTUF8wMzMnLCdTUF8wMzQnLCdTUF8wMzUnLCdTUF8wMzYnLCdTUF8wMzcnLCdTUF8wMzgnLCdTUF8wMzknLCdTUF8wNDAnLCdTUF8wNDEnLCdTUF8wNDInLCdTUF8wNDMnLCdTUF8wNDQnLCdTUF8wNDUnLCdTUF8wNDYnLCdTUF8wNDcnLCdTUF8wNDgnLCdTUF8wNDknLCdTUF8wNTAnLCdTUF8wNTEnLCdTUF8wNTInLCdTUF8wNTMnLCdTUF8wNTQnLCdTUF8wNTUnLCdTUF8wNTYnLCdTUF8wNTcnLCdTUF8wNTgnLCdTUF8wNTknLCdTUF8wNjAnLCdTUF8wNjEnLCdTUF8wNjInLCdTUF8wNjMnLCdTUF8wNjQnLCdTUF8wNjUnLCdTUF8wNjYnLCdTUF8wNjcnLCdTUF8wNjgnLCdTUF8wNjknLCdTUF8wNzAnLCdTUF8wNzEnLCdTUF8wNzInLCdTUF8wNzMnLCdTUF8wNzQnLCdTUF8wNzUnLCdTUF8wNzYnLCdTUF8wNzcnLCdTUF8wNzknLCdTUF8wODAnLCdTUF8wODEnLCdTUF8wODInLCdTUF8wODMnLCdTUF8wODQnLCdTUF8wODUnLCdTUF8wODYnLCdTUF8wODgnLCdTUF8wODknLCdTUF8wOTAnLCdTUF8wOTEnLCdTUF8wOTInLCdXSF8wMScsJ1dIXzAyJywnV0hfMDMnLCdXSF8wNCcsJ1dIXzA1JywnV0hfMDYnLCdXSF9EUk0nLCdXSF9WZW5kJyIsIlN0b3JlSUQiOiInJywnSE8nLCdPRkInLCdITycsJ0hPJywnUCZFJywnU01BJywnQktXJywnQkNDJywnQlNUJywnSERMJywnREFNJywnSklEJywnQlVLJywnUkFNJywnQ0NCJywnSE1UJywnTUhSJywnQU1CJywnQlNTJywnJywnSE8nLCdITycsJycsJ0pETycsJ01ETycsJ0hPJywnSE8nLCcnLCdITycsJ1AmRScsJ0tBUycsJ0tBU1MnLCdKUUInLCdEQVQnLCdEQVRTJywnTk9SJywnQVNNJywnVEJBJywnQVpNJywnQktSJywnU0tEJywnVEdNJywnT0JNJywnSlVNJywnUUJBJywnS09TJywnU1NKJywnTU9OJywnU0FGJywnUUJGJywnS01TJywnS01TUycsJ01BRycsJ1lSTScsJ01VRycsJ01SSicsJ1NRSicsJ01ESCcsJ01ERycsJ01DVCcsJ01DVFMnLCdWTUNUJywnUkhCJywnT0JIJywnQkFTJywnS1NWJywnJywnSE8nLCcnLCdITycsJ0hPJywnUCZFJywnS1NNJywnSlJLJywnS01BJywnS09EJywnR0FUJywnQkxWJywnTUdUJywnTUdDJywnJywnSE8nLCdITycsJ09GTycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdQJkUnLCdTTVQnLCdTS0snLCdTRUInLCdCUksnLCdTTEwnLCdTVVInLCdOSVonLCdTV1EnLCdTT00nLCdTQU0nLCdCUk0nLCdFQlInLCdTQlgnLCdCRFknLCdLQlInLCdBTVInLCdTTk0nLCdBVk0nLCdMV00nLCdKTE4nLCdBS00nLCdBS0InLCdNU04nLCdTTlcnLCdSU1QnLCdCUkEnLCdZQU4nLCdTTE4nLCdTTFUnLCdTQUQnLCdNT00nLCdRVVInLCdCSUQnLCdLQU0nLCdLVUQnLCdTTUwnLCdTTlMnLCdDQ00nLCdNT08nLCdDQ1MnLCdKTFMnLCdPQVMnLCdTU1MnLCdETksnLCdCSEwnLCdNQVQnLCdBTlMnLCdBU0snLCdLQlMnLCdTTVMnLCdGTEonLCdEUU0nLCdFQlMnLCdGQU4nLCdCRFMnLCdBTVMnLCdCREQnLCdPT1MnLCdUTUQnLCdTV1MnLCdNVVMnLCdITycsJycsJycsJycsJycsJycsJycsJycsJycsJycsJ09GUScsJ0hPJywnJywnSE8nLCdITycsJ0hPJywnUCZFJywnSE8nLCdBWlknLCdTSEYnLCdOU1InLCdESEYnLCdNUVInLCdBTUonLCdET00nLCdBTUsnLCdMQkInLCdBV1MnLCdNUksnLCdBRlMnLCdXQVEnLCdRT1MnLCdRUk4nLCdJR1cnLCdFWkQnLCdWSUwnLCdOQVMnLCdTSE4nLCdXQVQnLCcnLCdITycsJ0hPJywnSE8nLCcnLCcnLCcnLCcnLCcnLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0FFQycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ1AmRScsJ0hPJywnSE8nLCcnLCcnLCdITycsJ0hPJywnREZNJywnQlNNJywnQk5ZJywnQ1RNJywnRE1LJywnS0hMJywnQUpDJywnTVpNJywnQUZNJywnQUFNJywnQldNJywnQlNHJywnQlNYJywnQUdNJywnQUJNJywnQUJDJywnTUZDJywnRFJDJywnREFGJywnRkpNJywnQUtIJywnS0hLJywnTU5NJywnUkFLJywnU0hNJywnTVJEJywnU1JDJywnU0JTJywnU01NJywnTUFNJywnVUFRJywnSlJOJywnSlJNJywnU1FNJywnUk1aJywnQVNTJywnQkFSJywnS0hNJywnTU9RJywnRExNJywnQVlSJywnVUNKJywnQUdaJywnUkhNJywnVUNBJywnVUNCJywnRkNDJywnR0JWJywnRFJNJywnU0NIJywnSFRUJywnTVNGJywnSk1NJywnWkNDJywnR1lNJywnRkNNJywnTVNNJywnREhEJywnUklGJywnS0JNJywnSE1EJywnUldEJywnS1dTJywnQUFLJywnQlJTJywnRE9TJywnU0xNJywnREVSJywnU0NEJywnS0xGJywnU0JBJywnTURNJywnSlJGJywnTExaJywnRkpTJywnUkZNJywnRE1CJywnTVJCJywnREhNJywnSURXJywnSkNQJywnRFNTJywnTVNLJywnSE1BJywnRElCJywnRFNRJywnVU1CJywnQUtEJywnSFRTJywnWUFTJywnR0JJJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnRFdTJywnJyIsIlRlcm1pbmFsSUQiOiIiLCJzYWxlc1BlcnNvbklkIjoiIiwiem9uZUlkIjoiJyonIiwiZXhwIjoxNzczNTU5MjYyfQ.JZfGnaPSXmCanQfq3OWPRkYqqzy_rM9LLyLLiTLMFOo"
            //         ]);

            //         $response = curl_exec($ch);

            //         if (curl_errno($ch)) {
            //             echo 'Error: ' . curl_error($ch);
            //         }

            //         curl_close($ch);

            //         // echo $response;
            //     }
            //     // exit;
            // }
        } catch (Throwable $exception) {
            return $this
                ->httpResponse()
                ->setError()
                ->setMessage($exception->getMessage());
        }

        return $this
            ->httpResponse()
            ->setMessage(trans('core/table::table.save_bulk_change_success'));
    }
}
