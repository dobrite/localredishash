require 'localredishash'

describe LocalRedisHash, '#initialize' do
  let(:hash) { LocalRedisHash.new }
  subject { hash }
  it { should respond_to :[], :use }
  it 'thinks therefore it is' do
    expect(hash).to be_an_instance_of LocalRedisHash
  end
  it 'holds a connection to redis' do
    expect(hash.class.redis).to be_an_instance_of Redis
  end
end
