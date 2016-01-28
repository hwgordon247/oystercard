require 'oystercard'

describe "Feature Test" do
  subject(:oystercard) {Oystercard.new}
    describe "EDGE FACTORS" do
      before do
        subject.top_up(20)
      end
      let(:s1) {Station.new(name: 'a', zone: 1)}
      let(:s2) {Station.new(name: 'b', zone: 1)}

      it 'charges a penalty fare when touch_in is missed' do
        expect{subject.touch_out s1}.to change{subject.balance}.by(-6)
      end

      it 'charges penalty when touch out is missed on a journey' do
        subject.touch_in(s1)
        expect{subject.touch_in(s2)}.to change{subject.balance}.by(-6)
      end
      describe 'after completion of successful trip' do
        before do
          subject.touch_in(s1)
          subject.touch_out(s2)
        end
        it 'charges illegal journey penalty when touch out missed' do
          subject.touch_in(s1)
          expect{subject.touch_in(s2)}.to change{subject.balance}.by(-6)
        end
        it 'charges illegal journey penalty when touch in missed' do
          expect{subject.touch_out(s2)}.to change{subject.balance}.by(-6)
        end
      end

    end
end
