# go-fxgen-builder

A Docker container to assist with turning Go functions written with `go-fxgen` into a zip file ready for Google Cloud Functions.

## Usage

You'll need three parameters:

1. `PACKAGE`: `github.com/jgensler8/helloworld`
2. `FUNCTION`: `hello` . This will be used as a go flag when compiling. This is useful when you need to define multiple files with main functions that must existing in the same directory.

This corresponds to the following `hello.go`:

```
package main

// +build hello

import (
  "fmt"
  "github.com/jgensler8/go-fxgen"
)

func main() {
  fxgen.FxBuilder
    .WithAuthorization("Auth0")
    .WithHandler(function(w Http.ResponseWriter, r http.Request){
      r.Write(fmt.Printf("Hello, %s", "world"))  
    })
    .Build()
    .Run()
}
```

You would then invoke the builder by mounting the directory to `/workdir`. You'll also need to mount a directory to `/output` to save the zip that is created.

```
export PACKAGE="github.com/jgensler8/helloworld"
export FUNCTION="hello"
docker run -it -e PACKAGE -e FUNCTION -v $PWD:/workdir -v $PWD/output:/output hub.docker.com/jgensl2/go-fxgen-builder
```

You should have an output directory with a directory for the function.

```
tree output
- output
-- hello
--- function.zip
```
