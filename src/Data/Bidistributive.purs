module Data.Bidistributive where

import Prelude

import Data.Bifunctor (class Bifunctor, bimap)
import Data.Bifunctor.Product (Product(..))

-- | Categorical dual of `Bitraversable`:
-- |
-- | - `bidistribute` is the dual of `bisequence`.
-- | - `bicollect` is the dual of `bitraverse`. 
class Bifunctor f <= Bidistributive f where
  bidistribute :: forall a b g. Functor g => g (f a b) -> f (g a) (g b)              
  bicollect :: forall a b c g. Functor g => (a -> f b c) -> g a -> f (g b) (g c)

instance bidistributiveProduct :: (Bidistributive f, Bidistributive g) => Bidistributive (Product f g) where
  bidistribute hp = 
    let 
      fst = map (\(Product fab _) -> fab) hp
      snd = map (\(Product _ gab) -> gab) hp
    in Product (bidistribute fst) (bidistribute snd)
  bicollect = bicollectDefault

-- | A default implementation of `bidistribute`, based on `bicollect`.
bidistributeDefault
  :: forall a b f g
   . Bidistributive f
  => Functor g
  => g (f a b)
  -> f (g a) (g b)
bidistributeDefault = bicollect id

-- | A default implementation of `bicollect`, based on `bidistribute`.
bicollectDefault
  :: forall a b c f g
   . Bidistributive f
  => Functor g
  => (a -> f b c)
  -> g a
  -> f (g b) (g c)
bicollectDefault f = bidistribute <<< map f

-- | Zip an arbitrary collection of bicontainers and summarize the results
cobitraverse
  :: forall a b c d f g
   . Bidistributive f
  => Functor g
  => (g a -> c)
  -> (g b -> d)
  -> g (f a b)
  -> f c d
cobitraverse f1 f2 = bimap f1 f2 <<< bidistribute
