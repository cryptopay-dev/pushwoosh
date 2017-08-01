require 'spec_helper'

describe Pushwoosh::Request do
  describe '#make_post!' do
    let(:body) do
      {
        request:
        {
          application: '555555',
          auth: '5555-5555',
          notifications:
          [{
            send_date: 'now',
            ios_badges: '+1',
            content: 'Testing'
          }]
        }
      }
    end

    let(:options) do
      {
        auth: '5555-5555',
        application: '555555',
        notification_options:
        {
          send_date: 'now',
          ios_badges: '+1',
          content: 'Testing'
        }
      }
    end

    let(:response) do
      double(:response, response_hash)
    end

    let(:response_hash) do
      {
        status_code: 200,
        status_message: 'OK',
        response: { 'Messages' => ['555555534563456345'] }
      }
    end

    context 'when url is empty' do
      it 'raises an error' do
        expect do
          described_class.new('', options)
        end.to raise_error Pushwoosh::Exceptions::Error, 'URL is empty'
      end
    end

    context 'when url is nil' do
      it 'raises an error' do
        expect do
          described_class.new(nil, options)
        end.to raise_error Pushwoosh::Exceptions::Error, 'URL is empty'
      end
    end
  end
end
