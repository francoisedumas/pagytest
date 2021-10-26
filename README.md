# README

## Navigate the posts with pagy
<img width="338" alt="Screenshot 2564-10-26 at 21 42 43" src="https://user-images.githubusercontent.com/33062224/138949719-555fafe4-6dbc-47f5-b56d-97a779263f4e.png">

## How to
Start with rails new
`rails new pagytest`
Go to the folder
`cd pagytest`
Run a scaffold to save time
`rails g scaffold BlogPost title body:text`
Run the migration
`rails db:migrate`


In the Gemfile add `gem 'pagy'` then `bundle`

In the blog_post_controller.rb update the index method
```ruby
def index
    @pagy, @blog_posts = pagy(BlogPost.all)
end
```
In application_controller.rb add

`include Pagy::Backend` comment we could add it only in the blog_post_controller.rb
In the application_helper.rb add
`include Pagy::Frontend`

In the views/blog_posts/index.html.erb at the bottom add
`<%== pagy_nav(@pagy) %>`

In your terminal run `rails c`
```shell
50.times do
  BlogPost.create title: "test post"
end
```

Then run a server with `rails s` & visit the page http://localhost:3000/blog_posts
Here you go! Enjoy
