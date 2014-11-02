# Module Documentation

## Module Data.Distributive

### Type Classes

    class (Functor f) <= Distributive f where
      distribute :: forall a g. (Functor g) => g (f a) -> f (g a)
      collect :: forall a b g. (Functor g) => (a -> f b) -> g a -> f (g b)


### Type Class Instances

    instance distributiveIdentity :: Distributive Identity


### Values

    cotraverse :: forall a b f g. (Distributive f, Functor g) => (g a -> b) -> g (f a) -> f b