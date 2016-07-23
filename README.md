# Install

TKTK

# Configure

This plugin reads settings from the `_config.yml` file. Add settings as attributes or an array of attributes for multiple files.

## Example

```yml
swagger:
  json: 'https://path.to.swagger'
```

Or

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

Optionally, set a cache attribute to save a local copy of the data in the `_data` directory:

```yml
jekyll_get:
  - id: swagger
    json: '...'
    cache: true
```

## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
