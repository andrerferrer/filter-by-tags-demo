# GOAL

This is a demo to show-case how to implement .

[You can also check my other demos](https://github.com/andrerferrer/dedemos/blob/master/README.md#ded%C3%A9mos).

## What needs to be done?

### 1. Add the migrations

We it's a N:N relationship, so, we need to have a join table.

The steps are:
#### 1.1. Create the Tags
```
rails g model Tag name
```
#### 1.2. Create the Join table
```
rails g model RestaurantTag restaurant:references tag:references
```
#### 1.3. Add validations and associations
In the Restaurant model we need to add:
```ruby
  has_many :restaurant_tags
  has_many :tags, through: :restaurant_tags
```
In the Tag model we need to add:
```ruby
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :restaurant_tags
  has_many :restaurants, through: :restaurant_tags
```
In the RestaurantTag model we need to add:
```ruby
  belongs_to :restaurant # This line should be here already
  belongs_to :tag # This line should be here already
  # Validates that a restaurant can't have the same tag twice (and vice-versa)
  validates_uniqueness_of :restaurant, scope: [:tag]
```

And we're good to go 🤓
Good Luck and Have Fun