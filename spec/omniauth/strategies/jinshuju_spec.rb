require 'spec_helper'
require 'omniauth-jinshuju'

describe OmniAuth::Strategies::Jinshuju do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }
  let(:app) {
    lambda do
      [200, {}, ["Hello."]]
    end
  }

  subject do
    OmniAuth::Strategies::Jinshuju.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) {
        request
      }
    end
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  it 'has a version number' do
    expect(OmniAuth::Jinshuju::VERSION).not_to be nil
  end

  describe '#client_options' do
    it 'has correct site' do
      expect(subject.client.site).to eq('https://api.jinshuju.net')
    end

    it 'has correct authorize_url' do
      expect(subject.client.options[:authorize_url]).to eq('https://account.jinshuju.net/oauth/authorize')
    end

    it 'has correct token_url' do
      expect(subject.client.options[:token_url]).to eq('https://account.jinshuju.net/oauth/token')
    end
  end

  describe '#callback_path' do
    it 'has the correct callback path' do
      expect(subject.callback_path).to eq('/auth/jinshuju/callback')
    end
  end

  describe '#uid' do
    before :each do
      allow(subject).to receive(:raw_info) { { 'id' => 'uid' } }
    end

    it 'returns the id from raw_info' do
      expect(subject.uid).to eq('uid')
    end
  end

  describe '#info' do
    before :each do
      allow(subject).to receive(:raw_info) { {} }
    end

    context 'has all the necessary fields' do
      it { expect(subject.info).to have_key :nickname }
      it { expect(subject.info).to have_key :email }
    end
  end

  describe '#extra' do
    before :each do
      allow(subject).to receive(:raw_info) { { status: 'active' } }
    end

    it { expect(subject.extra[:raw_info]).to eq({ status: 'active' }) }
  end

  describe '#raw_info' do
    before :each do
      access_token = double('access token')
      response = double('response', :parsed => { status: 'active' })
      expect(access_token).to receive(:get).with('v4/me').and_return(response)
      allow(subject).to receive(:access_token) { access_token }
    end

    it 'returns parsed response from access token' do
      expect(subject.send(:raw_info)).to eq({ status: 'active' })
    end
  end

  describe '#access_token' do
    before :each do
      response = double('access token',
        access_token: 'access_token',
        refresh_token: 'refresh_token',
        expires_in: 3600,
        expires_at: 12345,
      ).as_null_object
      allow(subject).to receive(:access_token) { response }
    end

    it { expect(subject.access_token.access_token).to eq('access_token') }
    it { expect(subject.access_token.expires_in).to eq(3600) }
    it { expect(subject.access_token.expires_at).to eq(12345) }
    it { expect(subject.access_token.refresh_token).to eq('refresh_token') }
  end
end
