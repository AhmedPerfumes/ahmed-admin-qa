<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Botble\Blog\Models\Post;
use Botble\Ecommerce\Models\Product;

class BlogController extends Controller
{
    public function getBlogs(Request $request)
    {
        $limit = (int)$request['limit'];
        $page = (int)$request['page'];

        $blogs = Post::select('id', 'name', 'description', 'image', 'created_at')->where('status', 'published')->paginate($limit);

        return response()->json($blogs);
    }


    public function getBlogDetails(Request $request)
    {
        $blog = $request['blog'];
        
        // $blog = Post::select('id', 'name', 'content', 'created_at')->where('status', 'published')
        $blog = DB::table('posts')
        // ->where('name', $blog)
        // ->select(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(name, ' &amp; ', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"))
        ->join('post_categories', 'post_categories.post_id', '=', 'posts.id', 'left')
        ->join('categories', 'categories.id', '=', 'post_categories.category_id', 'left')
        ->select('posts.id', 'posts.name', 'posts.content', 'posts.image', 'posts.created_at', 'categories.name as category_name')
        ->where('posts.status', 'published')
        ->where('categories.status', 'published')
        ->where(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(posts.name, '&amp;', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"), '=', implode('', explode(' ', $blog)))
        ->first();

        // if(!$blog) {
        //     return response()->json([
        //         'message' => 'No Blog Found'
        //     ]);
        // }

        return response()->json($blog);
    }

    public function getBlogSEO(Request $request)
    {
        $blog = $request['blog'];
        
        // $blog = Post::select('id', 'name', 'content', 'created_at')->where('status', 'published')
        $blg = DB::table('posts')
        // ->where('name', $blog)
        // ->select(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(name, ' &amp; ', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"))
        ->join ('meta_boxes', 'meta_boxes.reference_id', '=', 'posts.id', 'left')
        // ->join('categories', 'categories.id', '=', 'post_categories.category_id', 'left')
        // ->select('posts.id', 'posts.name', 'posts.content', 'posts.image', 'posts.created_at', 'categories.name as category_name')
        ->select('meta_value')
        ->where('posts.status', 'published')
        // ->where('categories.status', 'published')
        ->where(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(posts.name, '&amp;', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"), '=', implode('', explode(' ', $blog)))
        ->where('meta_key', 'seo_meta')
        ->where('reference_type', 'Botble\Blog\Models\Post')
        ->first();

        // if(!$blog) {
        //     return response()->json([
        //         'message' => 'No Blog Found'
        //     ]);
        // }

        return response()->json($blg);
    }
}
