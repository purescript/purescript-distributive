# Module Documentation

## Module Data.Distributive

#### `Distributive`

``` purescript
class (Functor f) <= Distributive f where
  distribute :: forall a g. (Functor g) => g (f a) -> f (g a)
  collect :: forall a b g. (Functor g) => (a -> f b) -> g a -> f (g b)
```

Categorical dual of `Traversable`:

- `distribute` is the dual of `sequence` - it zips an 
  arbitrary collection of containers
- `collect` is the dual of `traverse` - it traverses 
  an arbitrary collection of values

#### `cotraverse`

``` purescript
cotraverse :: forall a b f g. (Distributive f, Functor g) => (g a -> b) -> g (f a) -> f b
```

Zip an arbitrary collection of containers and summarize the results

#### `distributiveIdentity`

``` purescript
instance distributiveIdentity :: Distributive Identity
```