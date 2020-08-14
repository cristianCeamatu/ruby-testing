require_relative '../lib/calculator'

describe Calculator do
  let(:calculator) { Calculator.new }

  describe '#add' do
    it 'returns the sum of 2 numbers' do
      expect(calculator.add(33, 32)).to eql(65)
    end

    it 'returns the sum of more then 2 numbers' do
      expect(calculator.add(2, 9, 11)).to eql(22)
    end
  end

  describe '#multiply' do
    it 'returns the multiplication of 2 numbers' do
      expect(calculator.multiply(2, 9)).to eql(18)
    end

    it 'returns the multiplication of more then 2 numbers' do
      expect(calculator.multiply(2, 2, 4)).to eql(16)
    end
  end

  describe '#subscribe' do
    it 'returns the subtraction of the first element minus the second element' do
      expect(calculator.substract(9, 19)).to eql(-10)
    end

    it 'returns the subtraction of the first element minus the remaining elements' do
      expect(calculator.substract(55, 5, 10)).to eql(40)
    end
  end

  describe '#divide' do
    it 'returns the division between the first and second element' do
      expect(calculator.divide(24, 6)).to eql(4)
    end

    it 'returns the division between the first and the other elements' do
      expect(calculator.divide(24, 6, 2)).to eql(2)
    end
  end
end
