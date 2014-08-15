require 'spec_helper'

describe Recipe do
  it { should validate_presence_of :name}
  it { should validate_presence_of :instructions}
  it { should validate_uniqueness_of :name }
end
