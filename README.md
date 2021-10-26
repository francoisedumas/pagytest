# README

`rails new pagytest`
`cd pagytest`
`rails g scaffold BlogPost title body:text`
`rails db:migrate`
`rails c`

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
