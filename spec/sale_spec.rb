require 'spec_helper'

describe Sale do
  it { should belong_to :cashier }
  it { should belong_to :customer }
  it { should have_many :products }
end
