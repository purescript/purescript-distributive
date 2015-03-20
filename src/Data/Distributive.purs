module Data.Distributive where

  import Data.Identity (runIdentity, Identity(..))

  -- | Categorical dual of `Traversable`:
  -- |
  -- | - `distribute` zips an arbitrary collection of containers
  -- | - `collect` traverses an arbitrary collection of values
  class (Functor f) <= Distributive f where
    -- | Default implementation: `distribute = collect id`
    distribute :: forall a g. (Functor g) => g (f a) -> f (g a)
    -- | Default implementation: `collect a2gb fa = distribute (a2gb <$> fa)`
    collect :: forall a b g. (Functor g) => (a -> f b) -> g a -> f (g b)

  -- | Zip an arbitrary collection of containers and summarize the results
  cotraverse :: forall a b f g. (Distributive f, Functor g) => (g a -> b) -> g (f a) -> f b
  cotraverse ga2b gfa = ga2b <$> distribute gfa

  instance distributiveIdentity :: Distributive Identity where
    distribute gIdb = Identity (runIdentity <$> gIdb)
    collect a2Idb ga = Identity ((runIdentity <<< a2Idb) <$> ga)
