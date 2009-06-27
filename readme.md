# loli

A minimum web dev DSL

## Example

First app

    -- myloli.hs
    
    import Network.Loli
    import Hack.Handler.Happstack
    
    main = run . loli $ get "/" (text "loli power")

Install and compile:

    cabal update
    cabal install loli
    cabal install hack-handler-happstack
    
    ghc --make myloli.hs
    ./myloli

check: <http://localhost:3000>


## Routes

### Verb

    get "/" $ do
      -- something for a get request

    post "/" $ do
      -- for a post request
    
    put "/" $ do
      -- put ..
    
    delete "/" $ do
      -- ..
### Captures

    get "/say/:user/:message" $ do
      text . show =<< captures

    -- /say/jinjing/hello will output
    -- [("user","jinjing"),("message","hello")]


## Static

    -- public serve, only allows /src
    public (Just ".") ["/src"]

## Views

    -- in `./views`, can be changed by
    views "template"

### Template

#### Text Template

    import Network.Loli.Template.TextTemplate
    
    -- template
    get "/hi/:user" $ output (TextTemplate "hello.html")
    
    -- in hello.html
    <html>
    <title>hello</title>
    <body>
      <p>hello $user</p>
    </body>
    </html>

#### Local binding

    get "/local-binding" $ do
      bind "user" "alice" $ output (TextTemplate "hello.html")

#### Batched local bindings

    get "/batched-local-binding" $ do
      context [("user", "alice"), ("password", "foo")] $ 
        text . show =<< locals

### Partials

Partials are treated the same as user supplied bindings, i.e. the rendered text is available to the rest of templates, referenced by user supplied keywords.

#### with single partial

    get "/single-partial" $ do
      partial "user" (ConstTemplate "const-user") $ do
        text . show =<< template_locals

#### with batched partials

    get "/group-partial" $ do
      partials 
        [ ("user", ConstTemplate "alex")
        , ("password", ConstTemplate "foo")
        ] $ output (TextTemplate "hello.html")

### Layout

### Local

    get "/with-layout" $ do
      with_layout "layout.html" $ do
        text "layout?"
    
    -- in layout.html
    <html>
    <body>
      <h1>using a layout</h1>
      $content
    </body>

### Global

    layout "layout.html"

### By passed

    get "/no-layout" $ do
      no_layout $ do
        text "no-layout"


## Mime types

    -- treat .hs extension as text/plain
    mime "hs" "text/plain"

## Note

If you see this, use the git version!