# GOAL

This is a demo to show-case how to use a rails app to implement tags and filter them in the view.

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

### 2. Create the filter

In the view, add this:
```erb
<% restaurant.tags.each do |tag| %>
  <%= link_to tag.name, restaurants_path(tag_id: tag.id), class: 'badge badge-dark' %>
<% end %>
```

In the controller, add this:
```ruby
  def index
    @restaurants = Restaurant.all
    @restaurants = tagged_restaurants(@restaurants) if params[:tag_id]
  end

  private

  def tagged_restaurants(restaurants)
    restaurants.joins(:restaurant_tags)
               .joins(:tags)
               .where('tags.id = ?', params[:tag_id])
  end  
```


And we're good to go 🤓
Good Luck and Have Fun