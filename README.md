# Populatr

Populatr works with AWS Cloudformation to provide a very simple integration in the form of a custom resource. Populatr takes a structured JSON Request from the AWS Cloudformation service and can create, update or delete keys and values inside Etcd.

This gem provides a CLI, but **is not hosted on Rubygems**. It is designed to be executed and ran from inside a Docker container.

## Running Populatr

The Docker container located at [stockflare/populatr]() will help you to easily get started with the Populatr gem. The CLI only supports a few commands, but the only one you should need is `start`.

---
`$ docker run --name populatr stockflare/populatr start --listen <sqs queue arn>`
---

## Inside the Cloudformation

So to integrate Populatr into our Cloudformation, we simply define it like we would any other resource in the resources block. In the snippet below, PopulatrServiceToken is being passed into the Cloudformation as a shared parameter and refers to the SNS Topic that an instance of Populatr is listening on.

```
{
  "Resources" : {

    ...

    "EnvironmentKeys" : {
      "Type": "Custom::Populatr",
      "Properties" : {
        "ServiceToken": { "Ref" : "PopulatrServiceToken" },
        "Keys" : [
          {
            "Key": "database/host",
            "Value" : "some-database-host.com"
          },
          {
            "Key" : "database/port",
            "Value" : "3306"
          },
          {
            "Key" : "some/temp/key",
            "Value" : "1337",
            "TTL" : "3000"
          }
        ]
      }
    },

    ...

  }
}
```
