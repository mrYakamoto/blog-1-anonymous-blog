# Blog 1 Anonymous Blog

## Learning Competencies

* Use the MVC pattern in web applications with proper allocation of code and responsibilities to each layer.
* Model relationships in a relational database (one-to-one, one-to-many, many-to-many).
* Use ActiveRecord to create Associations between database tables.
* Use ActiveRecord Validations.
* Use unit tests to ensure model function
* Use controller tests to ensure controller function

## Summary

We're going to write a simple homepage with a blog. This will be our first
many-to-many relationship inside the context of Sinatra. Later, we'll
integrate user authentication.

Do the [Sinatra sandbox challenge][sandbox challenge] first if you don't feel
comfortable with the flow of a web application or how forms send data to the
server.

We'll have two core models: `Post`s and `Tag`s. A `Post` can have many `Tag`s
and a `Tag` can be on many `Post`s.

## Skeleton

Clone the [Sinatra Skeleton](../../../sinatra_skeleton_mvc) into the current
directory with: `git clone SINATRA_SKELETON_URI`

Check reality by running `ls`, you should see:

```
README.md            sinatra_skeleton_mvc
```

`cd` into the `sinatra_skeleton_mvc` directory.

Remove the `.git` directory from `sinatra_skeleton_mvc` with `rm -rf .git/`

Add the `sinatra_skeleton_mvc` directory to the project with `git add .` then
commit with `git commit -m "Adds Sinatra Skeleton."`

## Releases

### Release 0: Controllers & Routes

Think about your controllers and routes. Consider making three controller files:

1. `app/controllers/index.rb`
2. `app/controllers/posts.rb`
3. `app/controllers/tags.rb`

The `index` controller will just have the index route, displaying your
homepage. All `Post`-related routes will go in the `posts` controller and all
`Tag`-related routes will go in the `tags` controller.

These are the operations we want to support for posts:

1. Show me all posts
2. Show me a particular post
3. Create a new post
4. Edit an existing post
5. Delete an existing post

We want to support the operation for tags: "Show me all posts with a given
tag."

Tags will be created via the `Post`-creation form.  You should add controller
tests for these routes.  We're not going to specify how to implement these
henceforth, but you are now responsible for realizing which routes should be
tested and how they should be tested.  Simply because the requirements of
challenges do not require you to write a test, you discern when the addition of
a test should be wise.  This is just like The Real World.&trade;

### Release 1: Models & Validations

Create all the necessary models and migrations to support the above. You
should have three models—what are they?

Add the appropriate validations to your models. Read the [Rails guide to
ActiveRecord validations][AR validations] for reference.

For example, if your `Post` model has `body` and `title` fields, you probably
don't want to permit a `Post` that has no `body` or `title` to be saved to the
database. This means adding `NOT NULL` constraints to the migrations and the
following validations to your ActiveRecord model:

```ruby
class Post < ActiveRecord::Base
  validates :body, :presence => true
  validates :title, :presence => true
end
```

You'll have other fields and validations, to be sure.  What fields do you want
your blog post to have?  Author?

### Release 2:  Add Unit Tests

Making sure that all your models are correct *without* automated testing is a
real bummer.  Try adding **UNIT TESTS**.

[Unit tests][] are short tests that verify your models function as expected.
The skeleton ships with a sample unit test to get you going (`band_spec`).  Try
creating a new `Post` that violates its constraints.  That instance should
return `false` for its [`valid?`][valid_invalid] method.  Or, you could ask
that instance for its [`.errors`][errors].  You can uses these data to build
tests to make sure your models function.

As you grow as a developer you'll discover models that aren't strictly bound to
a table and you'll want to test them as well. Imagine an `EncryptionService` or
an `AnagramGenerator` class.  These classes would definitely benefit from
having unit tests around them to verify that their implementations work.  To
help you on that path the skeleton ships with a non-Active Record-backed model
and spec (`demo` and `demo_spec`, repsectively).

While it may not have been said explicitly it's worth saying it now:  **MODELS
IN THE MVC PATTERN DO NOT HAVE TO BE BACKED BY A TABLE / IMPLEMENT
`ActiveRecord::Base`**

Good unit testing is a powerful tool in helping to create good
object-orientation!

### Release 3: Design Simple Pages and Forms

Design simple pages and forms to implement all the above functionality. It
doesn't need to be styled well, but if your HTML is well-structured it will
make it easier to style later.

Your forms for creating and updating `Post` models should allow you to enter
tags. You can decide how that works, although from a user experience
perspective it would be incredibly tedious to have to create tags elsewhere
before a post author can use them. However, if a post author uses a tag that
already exists, you aren't going to want to create a new row in the `tags`
table, but rather re-use the already-existing tag.

One idea might be to permit them to enter tags like this:

```html
<label for="post_tags">Tags:</label>
<input id="post_tags" name="post[tags]" value="tag1, tag2, some other tag, a fourth tag">
```

which renders as:

<label for="post_tags">Tags:</label>
<input id="post_tags" name="post[tags]" value="tag1, tag2, some other tag, a fourth tag" class="span4">

All your routes should now implement their basic functionality. You should be
able to list, show, create, update, and delete posts. You should also be able
to see all posts for a given tag at a url like

```text
http://localhost:9393/tag/apple
```

### Release 3: Error Cases

Using [valid? and invalid?][valid_invalid] and the [errors][errors] methods,
make sure you're handling your error cases gracefully. It doesn't need to be
perfect, but good error handling means:

1. When a user makes a mistake or breaks some rule, they're informed
2. The user is presented with an opportunity to correct the mistake, if possible
3. The user is given as much guidance as possible about that they need to do to fix the error

### Release 4: Style! Style! Style!

You might want to do the [Layout Drill: Proper Typesetting][proper formatting
challenge] first, if you haven't. But following the guidelines from that
challenge, spruce up your blog design.

Make it something you're proud to look at.

## Resources

* [Unit tests][]
* [DBC Sandbox Challenge][sandbox challenge]
* [DBC Proper Typesetting Challenge][proper formatting challenge]
* [ActiveRecord validations][AR validations]
* [ActiveRecord valid? and invalid?][valid_invalid]
* [ActiveRecord errors][errors]

[sandbox challenge]: ../../../sinatra-sandbox-challenge
[proper formatting challenge]: ../../../layout-drill-proper-typesetting-challenge
[AR validations]: http://guides.rubyonrails.org/active_record_validations_callbacks.html
[valid_invalid]: http://guides.rubyonrails.org/active_record_validations_callbacks.html#valid-and-invalid
[errors]: http://guides.rubyonrails.org/active_record_validations_callbacks.html#validations_overview-errors
[Unit tests]: http://en.wikipedia.org/wiki/Unit_testing
