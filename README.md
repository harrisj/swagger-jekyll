# Swagger Jekyll

Although Swagger has its own UI for sharing documentation, sometimes
you want to just build static API files that mix in with your existing
documentation. This gem is for that purpose, providing a mechanism to
load one or more Swagger files into a simple DOM and iterate through
them to render API documentation on your web page.

Why not use one of the existing Jekyll libraries for loading JSON
files? Well, Swagger is a little complicated in that it will often use
JSON Pointers and such that are beyond the abilities of basic JSON
libraries. I also wanted to have some ability to define things like
"example values for Boolean type," and it's much more
maintainable/reusable if I can do that via polymorphism rather than a
bunch of intertwined `if-else-endif` declarations embedded within
Jekyll templates.

This is also not a Swagger validator. It assumes that you are giving
it a valid Swagger 2.0 JSON file to use and if not, it will likely
break in weird ways.

This is still very much **SUPER ALPHA SOFTWARE**. We built this to
automate generation of the API documentation for Micropurchase, so all
the early functionality was driven by our specific documentation
format and needs. It very likely is missing some important feature
you'd like to add. Feel free to file a pull request though at any time
and pardon all the dust.

# Install

The best way to install this is to add it to a Bundler Gemfile for your Jekyll.

``` ruby
group :jekyll_plugins do
  gem 'swagger_jekyll'
end
```

Then run `bundle install` to install the gem and its dependency. For
the immediate term, you might need to actually install the gem
directly from Github (this is also how to get the latest version)

``` ruby
group :jekyll_plugins do
  gem 'swagger_jekyll', github: "harrisj/swagger_jekyll", branch: "master"
end
```

# Configure

This plugin reads settings from the `_config.yml` file. Add settings as attributes or an array of attributes for multiple files.

## Example

```yml
swagger:
  json: 'https://path.to.swagger.json'
```

This will load the Swagger file into `site.data.swagger` and you can then use that in your templates like `{{ site.data.swagger.base_path }}`

Alternatively, you can load several Swagger files on startup. The `id`
field is used to name them (and it defaults to 'swagger' if not
provided). In this example, we could reference
`site.data.api_v0.paths` in our Jekyll templates or such.

```yml
swagger:
  - id: api_v0
    json: 'swagger_v0'
  - id: api_v1
    json: 'swagger_v1'
```

Use in a liquid template as if it were a local data file:

```liquid
{% for path in site.data.swagger.paths %}
...
{% endfor %}
```

Optionally, you can also set a cache attribute to save a local copy of the data in the `_data` directory:

```yml
jekyll_get:
  - id: swagger
    json: '...'
    cache: true
```

# The Swagger DOM

This plugin defines a simple document object model for traversing
Swagger documents. Despite there being several Ruby gems for Swagger
generation/validation, none of them define a way of representing the
Swagger document itself like this. This DOM is not formally derived
from the Swagger JSON itself and is also incomplete, but it is useful
for the immediate needs of documentation. To be honest, it probably
could be revised in significant ways, but it serves the needs of this
gem so far.

## Specification

The top-level element of the Swagger JSON. This contains the following
fields for your Liquid templates:

|Field|Definition|
|-----|----------|
|base_path|The value of the basePath field|
|paths|An array of Path objects|
|definitions|An array of Definition objects|

## Path

Represents a single Path (ie, `/auctions/`) among the paths of your API

|Field|Definition|
|-----|----------|
|path|The value of the current path|
|verbs|An array of Verb objects|

## Verb

Represents a single verb (ie, `get`) among the verbs for a specific path

|Field|Definition|
|-----|----------|
|verb|The verb for this object|
|summary|A short summary of the verb from the Swagger JSON|
|description|A description of the verb|
|responses|An array of Response objects for this Verb|
|sample_response|A shortcut to return a pretty-printed JSON example for the 200 response if available|

## Response

Represents a single response (ie, `200`) for a verb/path in the Swagger JSON

|Field|Definition|
|-----|----------|
|code|The HTTP status code for this response|
|display_type|A compact representation of the response type|
|description|A description of the response if provided. This can be passed to Jekyll's `markdownify` filter if in markdown.|

## Schema

This is a convenient way of rendering a specific schema object defined
in Swagger's `definitions` section. Note that Response objects also
let you see the schema defined for them. Note that Schemas can include
references to other schemas.

|Field|Definition|
|-----|----------|
|name|The name of the schema if provided as a key within the `definitions` hash|
|title|The title of the schema object from a `title` field|
|description|A description of the Schema object if provided|
|display_type|A compact representation of the schema for use in property/response tables|
|example|A sample value for the schema. This might not be provided for all Schema types|
|properties|A list of Schema objects that are specified as properties for this schema.|

Although the Swagger schema (and the JSON Schema from which it is
derived), don't formally describe a collection of Array types, I found
it useful to create several distinct subclasses of Schema to encode
specific behaviors. So, a schema of type `string` might have specific
examples depending on what its `format` is or an `allOf` class would
need to concatenate the properties of all its members to return its
own properties. These classes are defined within the
`SwaggerJekyll::Schema` namespace and all support the same interface
above, although they may vary a little in implementation.

# Public domain

This project is in the worldwide [public domain](LICENSE.md). As
stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and
>copyright and related rights in the work worldwide are waived through
>the
>[CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>All contributions to this project will be released under the CC0
>dedication. By submitting a pull request, you are agreeing to comply
>with this waiver of copyright interest.
