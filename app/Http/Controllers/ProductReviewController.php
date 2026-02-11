<?php

namespace App\Http\Controllers;

use App\Models\ProductReview;
use App\Tables\ProductReviewTable;
use Botble\Base\Http\Responses\BaseHttpResponse;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;

class ProductReviewController extends Controller
{
    public function index(ProductReviewTable $table)
    {
        return $table->renderTable();
    }

    public function show(ProductReview $productReview)
    {
        page_title()->setTitle('Review Details');
        return view('admin.reviews.show', ['review' => $productReview]);
    }

    // v-- ADD THIS NEW FUNCTION TO HANDLE THE APPROVAL --v
    public function approve(ProductReview $productReview, Request $request)
    {
        // Set the status to the system's "PUBLISHED" value
        $productReview->status = 'published';
        $productReview->save();

        $couponSuccess = false;
        $selectedCouponId = $request->input('couponId');

        if ($productReview->customer_phone && $selectedCouponId) {
            try {
                $apiUrl = env('SMART_VIEW_COUPON_API_URL') . 'Coupon/Register';

                $postData = [
                    'couponId'     => $selectedCouponId,
                    'customerName' => $productReview->customer_name,
                    'mobileNo'     => $productReview->customer_phone,
                    'email'     => $productReview->customer_email,
                ];
                $ch = curl_init($apiUrl);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_POST, true);
                curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($postData));
                curl_setopt($ch, CURLOPT_HTTPHEADER, [
                    'Content-Type: application/json',
                ]);
                $apiResponse = curl_exec($ch);
                Log::info("Api Response". $apiResponse);
                
                if (!curl_errno($ch)) {
                    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
                    if ($httpCode >= 200 && $httpCode < 300) {
                        $couponSuccess = true;
                        Log::info("Coupon registered for review ID {$productReview->id}");
                    }
                } else {
                    Log::error("Coupon API Error: " . curl_error($ch));
                }
                curl_close($ch);
                
            } catch (\Exception $e) {
                Log::error("Coupon Integration Failed: " . $e->getMessage());
            }
        }

        $this->sendApprovalEmail($productReview, $couponSuccess, $selectedCouponId);
        return back()->with('success_message', 'Review published. ' . ($couponSuccess ? 'Coupon assigned.' : 'Coupon assignment failed (check logs).'));
    }

    private function sendApprovalEmail($productReview, $couponAssigned, $couponId = null)
    {
        $mail = new PHPMailer(true);
        try {
            $product = $productReview->product;
            $productName = $product ? $product->name : 'the product';

            $customerName = htmlspecialchars($productReview->customer_name);
            $safeProductName = htmlspecialchars($productName);
            $safeComment = nl2br(htmlspecialchars($productReview->comment));
            $voucherCodeText = 'SURVEY10'; 
            if ($couponId == env('REVIEW_COUPON_ID_15')) {
                $voucherCodeText = 'SURVEY15';
            }

            // Determine Coupon Content
            $couponHtml = '';
            if ($couponAssigned) {
                $couponHtml = '
                <!-- Gift Context -->
                <p class="font-sans text-center uppercase tracking-wide"
                    style="font-size: 11px; color: #999999; margin-bottom: 20px; text-transform: uppercase; letter-spacing: 2px;">
                    A Token of Our Appreciation
                </p>

                <!-- Voucher Card -->
                <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom: 20px;">
                    <tr>
                        <td align="center">
                            <!-- Card Container -->
                            <div class="voucher-card"
                                style="background-color: #111111; border-radius: 8px; max-width: 380px; width: 100%; overflow: hidden; box-shadow: 0 15px 35px rgba(0,0,0,0.2); position: relative;">

                                <!-- Decorative Border -->
                                <div style="position: absolute; top: 10px; left: 10px; right: 10px; bottom: 10px; border: 1px solid rgba(199, 148, 75, 0.3); border-radius: 6px; pointer-events: none;"></div>

                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <!-- Card Header -->
                                    <tr>
                                        <td style="padding: 30px 30px 10px 30px;">
                                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td align="left">
                                                        <img src="https://admin.ahmedalmaghribi.com/public/storage/ahmedlogo.png" width="40" alt="Logo" style="opacity: 0.9; display: block;">
                                                    </td>
                                                    <td align="right">
                                                        <p class="font-sans" style="color: #C7944B; font-family: Helvetica, Arial, sans-serif; font-size: 10px; letter-spacing: 2px; text-transform: uppercase; margin: 0;">Exclusive</p>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <!-- Card Code -->
                                    <tr>
                                        <td align="center" style="padding: 20px 0;">
                                            <p class="font-sans" style="color: #888888; font-family: Helvetica, Arial, sans-serif; font-size: 10px; letter-spacing: 1px; margin-bottom: 5px;">VOUCHER CODE</p>
                                            
                                            <h2 class="font-sans" style="color: #ffffff; font-family: Helvetica, Arial, sans-serif; font-size: 28px; letter-spacing: 4px; font-weight: 700; margin: 0; text-shadow: 0 2px 10px rgba(199, 148, 75, 0.3);">' . $voucherCodeText . '</h2>
                                            
                                        </td>
                                    </tr>

                                    <!-- Card Footer -->
                                    <tr>
                                        <td style="padding: 10px 30px 30px 30px;">
                                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td align="center">
                                                        <p class="font-sans" style="color: #C7944B; font-family: Helvetica, Arial, sans-serif; font-size: 11px; letter-spacing: 1px;">VALID FOR NEXT PURCHASE</p>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>

                <!-- CTA Button -->
                <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom: 20px;">
                    <tr>
                        <td align="center">
                            <a href="https://www.ahmedalmaghribi.com"
                                style="background-color: #C7944B; color: #ffffff; padding: 16px 40px; font-family: Helvetica, Arial, sans-serif; font-size: 13px; font-weight: bold; letter-spacing: 1px; text-transform: uppercase; text-decoration: none; display: inline-block; border-radius: 2px;">Shop Now</a>
                        </td>
                    </tr>
                </table>

                <!-- Instructions -->
                <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #F9F9F9; border-radius: 4px; margin-bottom: 20px;">
                    <tr>
                        <td style="padding: 25px;">
                            <p class="font-sans" style="color: #111111; font-family: Helvetica, Arial, sans-serif; font-size: 12px; font-weight: bold; margin-bottom: 10px; text-transform: uppercase; letter-spacing: 1px;">Redemption Instructions</p>
                            <ol class="font-sans" style="margin: 0; padding-left: 20px; color: #666666; font-family: Helvetica, Arial, sans-serif; font-size: 13px; line-height: 1.6;">
                                <li style="margin-bottom: 5px;">Visit <a href="https://www.ahmedalmaghribi.com" style="color: #C7944B; text-decoration: none; border-bottom: 1px solid #C7944B;">ahmedalmaghribi.com</a></li>
                                <li style="margin-bottom: 5px;">Select your desired fragrances.</li>
                                <li style="margin-bottom: 5px;">Use the mobile number registered with this review.</li>
                                <li>Apply code <strong>' . $voucherCodeText . '</strong> at checkout.</li>
                            </ol>
                        </td>
                    </tr>
                </table>';
            }

            /* Email SMTP Settings */
            $mail->SMTPDebug = 0;
            $mail->isSMTP();
            $mail->Host       = env('MAIL_HOST');
            $mail->SMTPAuth   = true;
            $mail->Username   = env('MAIL_USERNAME');
            $mail->Password   = env('MAIL_PASSWORD');
            $mail->SMTPSecure = env('MAIL_ENCRYPTION');
            $mail->Port       = env('MAIL_PORT');

            $mail->setFrom(env('MAIL_FROM_ADDRESS'), env('MAIL_FROM_NAME'));
            $mail->addAddress($productReview->customer_email, $productReview->customer_name);
            $mail->isHTML(true);
            $mail->Subject = "Your review for {$safeProductName} is live!";

            // Inject Coupon HTML into the body
            $body = '
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Review Status Update</title>
                <style>
                    /* Reset & Base */
                    body, table, td, p, a, h1, h2, h3 { margin: 0; padding: 0; border: 0; }
                    body { background-color: #F5F5F5; font-family: Helvetica, Arial, sans-serif; -webkit-font-smoothing: antialiased; }
                    table { border-collapse: collapse; border-spacing: 0; mso-table-lspace: 0pt; mso-table-rspace: 0pt; }
                    img { border: 0; display: block; outline: none; text-decoration: none; }
                    
                    /* Utilities */
                    .font-serif { font-family: "Times New Roman", serif; }
                    .font-sans { font-family: Helvetica, Arial, sans-serif; }
                    .text-gold { color: #C7944B; }
                    .text-black { color: #111111; }
                    .text-gray { color: #666666; }
                    .text-center { text-align: center; }
                    .uppercase { text-transform: uppercase; }
                    .tracking-wide { letter-spacing: 2px; }

                    /* Mobile */
                    @media screen and (max-width: 600px) {
                        .wrapper { width: 100% !important; padding: 0 !important; }
                        .content { padding: 30px 20px !important; }
                        .voucher-card { width: 100% !important; }
                    }
                </style>
            </head>
            <body style="background-color: #F5F5F5; margin: 0; padding: 0;">

                <!-- Main Wrapper -->
                <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #F5F5F5;">
                    <tr>
                        <td align="center" style="padding: 10px 0;">

                            <!-- Container -->
                            <table class="wrapper" width="600" cellpadding="0" cellspacing="0" border="0"
                                style="background-color: #ffffff; box-shadow: 0 10px 40px rgba(0,0,0,0.08);">

                                <!-- Top Bar -->
                                <tr>
                                    <td align="center" style="background-color: #000000; padding: 12px;">
                                        <p class="font-sans uppercase tracking-wide"
                                            style="color: #C7944B; font-family: Helvetica, Arial, sans-serif; font-size: 10px; margin: 0; text-transform: uppercase; letter-spacing: 2px;">Review Status Update</p>
                                    </td>
                                </tr>

                                <!-- Logo Section -->
                                <tr>
                                    <td align="center" style="padding: 20px 0;">
                                        <img src="https://admin.ahmedalmaghribi.com/public/storage/ahmedlogo.png"
                                            alt="Ahmed Al Maghribi" width="90" style="display: block;">
                                    </td>
                                </tr>

                                <!-- Main Content -->
                                <tr>
                                    <td class="content" style="padding: 0 60px 0px 60px;">

                                        <!-- Heading -->
                                        <h1 class="font-serif text-black text-center"
                                            style="font-family: \'Times New Roman\', serif; font-size: 32px; font-weight: 400; margin-bottom: 20px; color: #111111; text-align: center;">Your Voice Matters</h1>

                                        <!-- Intro Text -->
                                        <p class="font-sans text-gray text-center"
                                            style="font-family: Helvetica, Arial, sans-serif; font-size: 15px; line-height: 1.8; margin-bottom: 10px; color: #666666; text-align: center;">
                                            Dear <strong>' . $customerName . '</strong>,<br>
                                            Thank you for sharing your exquisite taste with us regarding <strong>' . $safeProductName . '</strong>. We are pleased to inform you that your review has been published.
                                        </p>

                                        <!-- Review Highlight -->
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0"
                                            style="background-color: #FAFAFA; border-left: 3px solid #C7944B; margin-bottom: 20px;">
                                            <tr>
                                                <td style="padding: 25px;">
                                                    <div style="margin-bottom: 10px; color: #C7944B; font-size: 20px; line-height: 1;">
                                                        ' . str_repeat("&#9733;", $productReview->star) . str_repeat("&#9734;", 5 - $productReview->star) . '
                                                    </div>
                                                    <p class="font-serif"
                                                        style="font-family: \'Times New Roman\', serif; font-style: italic; font-size: 16px; color: #333333; line-height: 1.6; margin: 0;">
                                                        "' . $safeComment . '"
                                                    </p>
                                                </td>
                                            </tr>
                                        </table>

                                        <!-- Divider -->
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td align="center" style="padding-bottom: 20px;">
                                                    <div style="width: 40px; height: 1px; background-color: #E0E0E0;"></div>
                                                </td>
                                            </tr>
                                        </table>

                                        <!-- INJECT COUPON HERE -->
                                        ' . $couponHtml . '

                                    </td>
                                </tr>

                                <!-- Footer -->
                                <tr>
                                    <td align="center" style="background-color: #111111; padding: 40px 20px;">
                                        <img src="https://admin.ahmedalmaghribi.com/public/storage/ahmedlogo.png"
                                            width="40" alt="Logo"
                                            style="opacity: 0.5; margin-bottom: 20px; filter: grayscale(100%);">
                                        <p class="font-sans"
                                            style="color: #666666; font-family: Helvetica, Arial, sans-serif; font-size: 11px; letter-spacing: 1px; line-height: 1.6; margin: 0;">
                                            &copy; ' . date("Y") . ' Ahmed Al Maghribi Perfumes.<br>All rights reserved.
                                        </p>
                                    </td>
                                </tr>

                            </table>

                            <!-- Unsubscribe / Browser Link -->
                            <table width="600" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td align="center" style="padding-top: 20px;">
                                        <p class="font-sans" style="color: #999999; font-family: Helvetica, Arial, sans-serif; font-size: 11px;">
                                            <a href="#" style="color: #999999; text-decoration: underline;">View in browser</a>
                                        </p>
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                </table>
            </body>
            </html>';

            $mail->Body = $body;
            $mail->send();
        } catch (Exception $e) {
            Log::error("Failed to send review approval email: {$mail->ErrorInfo}");
        }
    }

    public function destroy(ProductReview $productReview, BaseHttpResponse $response)
    {
        $productReview->status = 'deleted'; // A new, custom status
        $productReview->save();

        // This sends back a standard success message that the admin table understands.
        return $response->setMessage('Review moved to trash successfully!');
    }
}