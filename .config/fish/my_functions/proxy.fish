function proxy
	argparse -n proxy 'n/none' 's/set' 'h/help' -- $argv
	or return 1

  set proxy http://proxy.nagaokaut.ac.jp:8080
  set -gx http_proxy ''
  set -gx https_proxy ''
  set -gx HTTP_PROXY ''
  set -gx HTTPS_PROXY ''

	if set -lq _flag_set

		set -gx http_proxy $proxy
		set -gx https_proxy $proxy
		set -gx HTTP_PROXY $proxy
		set -gx HTTPS_PROXY $proxy

		npm -g config set proxy http://proxy.nagaokaut.ac.jp:8080
		npm -g config set proxy https-proxy http://proxy.nagaokaut.ac.jp:8080
		npm -g config set registry http://registry.npmjs.org/

    yarn config set proxy $proxy -g
    yarn config set https-proxy $proxy -g

		git config --global http.proxy $proxy
		git config --global https.proxy $proxy
		git config --global url."https://".insteadOf git://

    echo $proxy
    echo $http_proxy
		echo 'set proxy'
		return
	end

	if set -lq _flag_none
		set -e http_proxy
		set -e https_proxy
		set -e HTTP_PROXY
		set -e HTTPS_PROXY

		npm -g config delete proxy
		npm -g config delete https-proxy
		npm -g config delete registry

    yarn config delete proxy -g
    yarn config delete https-proxy -g

		git config --global --unset http.proxy
		git config --global --unset https.proxy
		git config --global --unset url."https://".insteadOf

		echo 'unset proxy'
		return
 	end

	if set -lq _flag_help
		echo 'This is help'
		echo '-s/--set : set proxy'
		echo '-n/--none : unset proxy '
		echo '-h/--help : display help'
		return
	end

end
