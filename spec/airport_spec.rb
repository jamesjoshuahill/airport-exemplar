require 'airport'

RSpec.describe Airport do
  let(:subject) { Airport.new(weather: weather) }
  let(:weather) { instance_double("Weather") }
  let(:plane) { instance_double("Plane") }

  before do
    allow(plane).to receive(:land)
    allow(weather).to receive(:outlook).and_return(:sunny)
  end

  it "has no planes" do
    expect(subject.planes).to be_empty
  end

  it "has capacity for 8 planes" do
    expect(subject.capacity).to eq(8)
  end

  context "when a plane lands" do
    it "instructs the plane to land" do
      subject.land(plane)

      expect(plane).to have_received(:land)
    end

    it "registers the landed plane" do
      subject.land(plane)

      expect(subject.planes).to include(plane)
    end

    it "rejects planes that have already landed" do
      subject.land(plane)

      expect { subject.land(plane) }.to raise_error "plane already landed"
    end
  end

  context "when a plane takes off" do
    before do
      allow(plane).to receive(:take_off)
      subject.land(plane)
    end

    it "instructs the plane to take off" do
      subject.take_off(plane)

      expect(plane).to have_received(:take_off)
    end

    it "deregisters the flying plane" do
      subject.take_off(plane)

      expect(subject.planes).not_to include(plane)
    end

    it "does not deregister other landed planes" do
      another_plane = instance_double("Plane")
      allow(another_plane).to receive(:land)
      subject.land(another_plane)

      subject.take_off(plane)

      expect(subject.planes).to include(another_plane)
    end

    it "rejects planes that have not already landed" do
      another_plane = instance_double("Plane")

      expect { subject.take_off(another_plane) }.to raise_error "plane not registered"
    end
  end

  context "when it is stormy" do
    before do
      subject.land(plane)
      allow(weather).to receive(:outlook).and_return(:stormy)
    end

    it "prevents planes from landing" do
      another_plane = instance_double("Plane")
      expect { subject.land(another_plane) }.to raise_error("not safe to land")
    end

    it "prevents planes from taking off" do
      expect { subject.take_off(plane) }.to raise_error("not safe to take off")
    end
  end

  context "when the airport is full" do
    let(:subject) { Airport.new(weather: weather, capacity: 0) }

    it "prevents planes from landing" do
      expect { subject.land(plane) }.to raise_error("airport full")
    end
  end
end
