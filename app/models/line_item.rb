class LineItem < ApplicationRecord

  belongs_to :order
  belongs_to :product

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true

end

function foo() {
  console.log("foo")
}

function bar() {
  foo();
  console.log("bar");
}

bar();

console.trace();