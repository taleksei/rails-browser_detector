require 'spec_helper'

RSpec.describe Rails::BrowserDetector::BrowserCompatible do
  let(:controller) { Object.new }

  before do
    Rails.application.config.compatible_browsers = {
      'Chrome'         => 45,
      'Yandex Browser' => 13,
      'Opera'          => 32,
      'Firefox'        => 42,
      'Firefox Alpha'  => 15,
      'IE'             => 10,
      'Safari'         => 7
    }

    controller.extend(Rails::BrowserDetector::BrowserCompatible)
  end

  describe '#browser_old?' do
    shared_examples_for 'not old browser' do |user_agent|
      before { allow(controller).to receive_message_chain(:request, :user_agent).and_return user_agent }

      it { expect(controller.send(:browser_old?)).to eq false }
    end

    shared_examples_for 'old browser' do |user_agent|
      before { allow(controller).to receive_message_chain(:request, :user_agent).and_return user_agent }

      it { expect(controller.send(:browser_old?)).to eq true }
    end

    context 'when used default compatible browsers' do
      context 'when browser is Chrome' do
        context 'when browser has old version' do
          user_agents = [
            'Mozilla/5.0 (Windows NT 6.1; WOW64)
              AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.62 Safari/537.36',
            'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.16 Safari/537.36',
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0)
              AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1664.3 Safari/537.36',
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.517 Safari/537.36',
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.137 Safari/4E423F',
            'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'
          ]

          user_agents.each { |user_agent| it_behaves_like 'old browser', user_agent }
        end

        context 'when browser has minimal compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko)
                            Chrome/45.0.2228.0 Safari/537.36'
        end

        context 'when browser has compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko)
                            Chrome/45.0.2228.0 Safari/537.36'
        end
      end

      context 'when browser is Firefox' do
        context 'when browser has old version' do
          user_agents = [
            'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040614 Firefox/0.9',
            'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-AU; rv:1.9.2.14) Gecko/20110218 Firefox/3.6.14',
            'Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.9.0.2) Gecko/20121223 Ubuntu/9.25 (jaunty) Firefox/3.8',
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20100101 Firefox/9.0',
            'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:21.0.0) Gecko/20121011 Firefox/21.0.0',
            'Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0',
            'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1'
          ]

          user_agents.each { |user_agent| it_behaves_like 'old browser', user_agent }
        end

        context 'when browser has minimal compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/42.3'
        end

        context 'when browser has compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/44.1'
        end
      end

      context 'when browser is Yandex Browser' do
        context 'when browser has old version' do
          user_agents = [
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/536.5 (KHTML, like Gecko)
              YaBrowser/1.0.1084.5402 Chrome/19.0.1084.5402 Safari/536.5',
            'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.5 (KHTML, like Gecko)
              YaBrowser/1.0.1084.5402 Chrome/19.0.1084.5402 Safari/536.5',
            'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/536.5 (KHTML, like Gecko)
              YaBrowser/1.0.1084.5402 Chrome/19.0.1084.5402 Safari/536.5',
            'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.12785
              YaBrowser/12.12.1599.12785 Safari/537.36',
            'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95
              YaBrowser/12.7.1916.15705 Safari/537.36'
          ]

          user_agents.each { |user_agent| it_behaves_like 'old browser', user_agent }
        end

        context 'when browser has minimal compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)
                            Chrome/39.0.2171.95 YaBrowser/13.7.1916.15705 Safari/537.36'
        end

        context 'when browser has compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)
                            Chrome/39.0.2171.95 YaBrowser/14.7.1916.15705 Safari/537.36'
        end
      end

      context 'when browser is Opera' do
        context 'when browser has old version' do
          user_agents = [
            'Opera/7.03 (Windows NT 5.0; U) [en]',
            'Opera/9.80 (Windows NT 6.0; U; en) Presto/2.8.99 Version/11.10',
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko)
              Chrome/44.0.2376.0 Safari/537.36 OPR/31.0.1857.0',
            'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)
              Chrome/45.0.2454.85 Safari/537.36 OPR/31.0.1948.25'
          ]

          user_agents.each { |user_agent| it_behaves_like 'old browser', user_agent }
        end

        context 'when browser has minimal compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)
                            Chrome/45.0.2454.85 Safari/537.36 OPR/32.0.1948.25'
        end

        context 'when browser has compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)
                            Chrome/45.0.2454.85 Safari/537.36 OPR/33.0.1948.25'
        end
      end

      context 'when browser is IE' do
        context 'when browser has old version' do
          user_agents = [
            'Mozilla/1.22 (compatible; MSIE 2.0; Windows 95)',
            'Mozilla/3.0 (compatible; MSIE 3.0; Windows NT 5.0)',
            'Mozilla/4.0 WebTV/2.6 (compatible; MSIE 4.0)',
            'Mozilla/4.0 (compatible; MSIE 5.15; Mac_PowerPC)',
            'Mozilla/4.08 (compatible; MSIE 6.0; Windows NT 5.1)',
            'Mozilla/5.0 (MSIE 7.0; Macintosh; U; SunOS; X11; gu; SV1; InfoPath.2;
              .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648)',
            'Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; GTB7.4;
              InfoPath.2; SV1; .NET CLR 3.3.69573; WOW64; en-US)',
            'Mozilla/5.0 (Windows; U; MSIE 9.0; Windows NT 9.0; en-US)'
          ]

          user_agents.each { |user_agent| it_behaves_like 'old browser', user_agent }
        end

        context 'when browser has minimal compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)'
        end

        context 'when browser has compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko'
        end
      end

      context 'when browser is Safari' do
        context 'when browser has old version' do
          user_agents = [
            'Mozilla/5.0 (Windows; U; Windows NT 6.0; ru-RU)
              AppleWebKit/528.16 (KHTML, like Gecko) Version/4.0 Safari/528.16',
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4)
              AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2',
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5)
              AppleWebKit/537.75.14 (KHTML, like Gecko) Version/6.1.3 Safari/537.75.14'
          ]

          user_agents.each { |user_agent| it_behaves_like 'old browser', user_agent }
        end

        context 'when browser has minimal compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3)
                            AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A'
        end

        context 'when browser has compatible version' do
          it_behaves_like 'not old browser',
                          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11)
                            AppleWebKit/601.1.39 (KHTML, like Gecko) Version/9.0 Safari/601.1.39'
        end
      end

      context 'when browser or version is not identified' do
        it_behaves_like 'not old browser', 'blabla'
        it_behaves_like 'not old browser', 'Links (2.7; Linux 3.7.9-2-ARCH x86_64; GNU C 4.7.1; text)'
      end

      context 'when browser is Firefox Alfa with not compatible version' do
        it_behaves_like 'old browser', 'Mozilla/5.0 (Windows NT 6.1; rv:14.0) Gecko/20120405 Firefox/14.0a1'
      end
    end
  end

  describe '#current_browser' do
    let(:user_agent) do
      'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2228.0 Safari/537.36'
    end

    before { allow(controller).to receive_message_chain(:request, :user_agent).and_return user_agent }

    it { expect(controller.send(:current_browser).family).to eq 'Chrome' }
    it { expect(controller.send(:current_browser).version.major).to eq '47' }

    context 'when browser is not identified' do
      let(:user_agent) { 'blabla' }

      it { expect(controller.send(:current_browser).family).to eq 'Other' }
      it { expect(controller.send(:current_browser).version).to be_nil }
    end
  end

  describe '#apple_device?' do
    let(:result) { controller.send(:apple_device?) }

    before { allow(controller).to receive_message_chain(:request, :user_agent).and_return user_agent }

    context 'when user agent for mobile device' do
      let(:user_agent) do
        'Mozilla/5.0 (Linux; Android 4.2.2; en-us; SAMSUNG SGH-M919 Build/JDQ39) ' \
        'AppleWebKit/535.19 (KHTML, like Gecko) Version/1.0 Chrome/18.0.1025.308 Mobile Safari/535.19'
      end

      it { expect(result).to eq false }
    end

    context 'when user agent for android device' do
      let(:user_agent) do
        'Mozilla/5.0 (Linux; U; Android 4.1.2; en-us; SM-T210R Build/JZO54K) ' \
        'AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Safari/534.30'
      end

      it { expect(result).to eq false }
    end

    context 'when user agent for iphone' do
      let(:user_agent) do
        'Mozilla/5.0 (iPhone; CPU iPhone OS 8_0_2 like Mac OS X) ' \
        'AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12A366 Safari/600.1.4'
      end

      it { expect(result).to eq true }
    end

    context 'when user agent for ipad' do
      let(:user_agent) do
        'Mozilla/5.0 (iPad; CPU OS 10_2_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko)' \
        ' GSA/23.1.148956103 Mobile/14D27 Safari/600.1.4'
      end

      it { expect(result).to eq true }
    end

    context 'when user agent for desktop' do
      let(:user_agent) do
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'
      end

      it { expect(result).to eq false }
    end
  end

  describe '#win_xp?' do
    let(:result) { controller.send(:win_xp?) }

    before { allow(controller).to receive_message_chain(:request, :user_agent).and_return user_agent }

    context 'when user agent for mobile device' do
      let(:user_agent) do
        'Mozilla/5.0 (Linux; Android 4.2.2; en-us; SAMSUNG SGH-M919 Build/JDQ39) ' \
        'AppleWebKit/535.19 (KHTML, like Gecko) Version/1.0 Chrome/18.0.1025.308 Mobile Safari/535.19'
      end

      it { expect(result).to eq false }
    end

    context 'when user agent for android device' do
      let(:user_agent) do
        'Mozilla/5.0 (Linux; U; Android 4.1.2; en-us; SM-T210R Build/JZO54K) ' \
        'AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Safari/534.30'
      end

      it { expect(result).to eq false }
    end

    context 'when user agent for iphone' do
      let(:user_agent) do
        'Mozilla/5.0 (iPhone; CPU iPhone OS 8_0_2 like Mac OS X) ' \
        'AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12A366 Safari/600.1.4'
      end

      it { expect(result).to eq false }
    end

    context 'when user agent for ipad' do
      let(:user_agent) do
        'Mozilla/5.0 (iPad; CPU OS 10_2_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko)' \
        ' GSA/23.1.148956103 Mobile/14D27 Safari/600.1.4'
      end

      it { expect(result).to eq false }
    end

    context 'when user agent for desktop' do
      let(:user_agent) do
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'
      end

      it { expect(result).to eq false }
    end

    context 'when user agent for windows xp' do
      let(:user_agent) do
        'User-Agent:Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) ' \
        'Chrome/49.0.2623.112 Safari/537.36'
      end

      it { expect(result).to eq true }
    end
  end
end
