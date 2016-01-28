require 'oystercard'

card = Oystercard.new
card.top_up 90
s1 = Station.new(name: "hello", zone: 1)
s2 = Station.new(name: "goodbye", zone: 5)


describe 'featuretest' do

  it 'weird bug' do
  card.touch_out s2
  expect(card.history).to eq [{:in => nil, :out => s2}]
end



end
