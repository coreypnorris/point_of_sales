require 'spec_helper'

describe Good do
  it { should belong_to :sale }
  it { should belong_to :product}
end
