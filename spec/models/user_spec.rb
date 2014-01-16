require 'spec_helper'

describe User do
  describe "validations" do
  	it { should validate_presence_of(:email) }
  	it { should validate_presence_of(:fname) }
  	it { should validate_presence_of(:lname) }
  	it { should validate_presence_of(:gender) }
  	it { should validate_presence_of(:session_token) }

  	it { should validate_uniqueness_of(:email) }

  	it { should ensure_length_of(:password) }

  	it { should ensure_inclusion_of(:gender).in_array(['m','f']) }
	end

	describe "associations" do
		it { should have_one(:profile) }
		it { should have_many(:in_friendships) }
		it { should have_many(:out_friendships) }
		it { should have_many(:statuses) }
		it { should have_many(:comments) }
		it { should have_many(:likes) }
		it { should have_many(:albums) }
		it { should have_many(:photos) }
		it { should have_many(:taggings) }
		it { should have_many(:out_message_threads) }
		it { should have_many(:in_message_threads) }
	end
end
