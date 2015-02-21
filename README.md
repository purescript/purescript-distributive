# Module Documentation

## Module Data.Distributive

#### `Distributive`

``` purescript
class (Functor f) <= Distributive f where
  distribute :: forall a g. (Functor g) => g (f a) -> f (g a)
  collect :: forall a b g. (Functor g) => (a -> f b) -> g a -> f (g b)
```

#### `cotraverse`

``` purescript
cotraverse :: forall a b f g. (Distributive f, Functor g) => (g a -> b) -> g (f a) -> f b
```

#### `distributiveIdentity`

``` purescript
instance distributiveIdentity :: Distributive Identity
```