import Network.Loli
import Hack.Handler.Happstack
import Hack
import Data.ByteString.Lazy.Char8 (pack)
import Data.Default
import Hack.Contrib.Middleware.BounceFavicon
import Hack.Contrib.Middleware.ContentLength
import Hack.Contrib.Middleware.ContentType
-- import Hack.Contrib.Middleware.ETag
-- import Hack.Contrib.Middleware.ShowExceptions
import Hack.Contrib.Middleware.Static
import Hack.Contrib.Middleware.URLMap
import Hack.Contrib.Utils (use)

default_content_type :: String
default_content_type = "text/plain; charset=UTF-8"

stack = 
  [    
    content_length
  , content_type default_content_type
  ]

main = run my_app

my_app = use stack loli_app

hello_app :: Application
hello_app = const $ return $ def {body = pack "hello world"}

loli_app = loli $ do
  public Nothing ["/src"]
  
  get "/hello" (text "hello")
  get "/" (html "<html><body><p>world</p></body></html>")
  
  mime "hs" "text/plain"