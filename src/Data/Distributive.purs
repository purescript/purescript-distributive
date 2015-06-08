module Data.Distributive where

import Prelude

import Control.Monad.Reader.Trans
import Data.Identity

-- | Categorical dual of `Traversable`:
-- |
-- | - `distribute` is the dual of `sequence` - it zips an
-- |   arbitrary collection of containers
-- | - `collect` is the dual of `traverse` - it traverses
-- |   an arbitrary collection of values
class (Functor f) <= Distributive f where
  -- | Default implementation: `distribute = collect id`
  distribute :: forall a g. (Functor g) => g (f a) -> f (g a)
  -- | Default implementation: `collect f = distribute <<< map f`
  collect :: forall a b g. (Functor g) => (a -> f b) -> g a -> f (g b)

-- | Zip an arbitrary collection of containers and summarize the results
cotraverse :: forall a b f g. (Distributive f, Functor g) => (g a -> b) -> g (f a) -> f b
cotraverse f = map f <<< distribute

instance distributiveIdentity :: Distributive Identity where
  distribute = Identity <<< map runIdentity
  collect f = Identity <<< map (runIdentity <<< f)

instance distributiveFunction :: Distributive ((->) e) where
  distribute a e = map ($ e) a
  collect f = distribute <<< map f

instance distributiveReaderT :: (Distributive g) => Distributive (ReaderT e g) where
  distribute a = ReaderT \e -> collect (flip runReaderT e) a
  collect f = distribute <<< map f
