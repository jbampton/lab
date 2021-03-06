# lab
<p align="center">
	<a href="https://goreportcard.com/report/github.com/MontFerret/lab">
		<img alt="Go Report Status" src="https://goreportcard.com/badge/github.com/MontFerret/lab">
	</a>
<!-- 	<a href="https://codecov.io/gh/MontFerret/lab">
		<img alt="Code coverage" src="https://codecov.io/gh/MontFerret/lab/branch/master/graph/badge.svg" />
	</a> -->
	<a href="https://discord.gg/kzet32U">
		<img alt="Discord Chat" src="https://img.shields.io/discord/501533080880676864.svg">
	</a>
	<a href="https://github.com/MontFerret/lab/releases">
		<img alt="Lab release" src="https://img.shields.io/github/release/MontFerret/lab.svg">
	</a>
   <a href="https://microbadger.com/images/montferret/lab">
      <img alt="Dockerimages" src="https://images.microbadger.com/badges/version/montferret/lab.svg">
   </a>
	<a href="http://opensource.org/licenses/MIT">
		<img alt="MIT License" src="http://img.shields.io/badge/license-MIT-brightgreen.svg">
	</a>
</p>

``lab`` is a test runner for [Ferret](https://www.github.com/MontFerret/ferret) scripts.

## Features
- Parallel execution
- Support of multiple types of remote runtime (local binaries or HTTP services)
- Support of multiple types of script locations (file system, git, http)
- Arbitrary amount of HTTP endpoints for serving static files

## Usage

```bash
NAME:
   lab - run FQL scripts

USAGE:
   ferret-lab [global options] command [command options] [arguments...]

VERSION:
   v0.1.0

DESCRIPTION:
   Ferret scripts runner

COMMANDS:
   help, h  Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --files value, -f value     Location of FQL script files to run [$FERRET_LAB_FILES]
   --cdp value                 Chrome DevTools Protocol address (default: "http://127.0.0.1:9222") [$FERRET_LAB_CDP]
   --filter value              filter test files [$FERRET_LAB_FILTER]
   --reporter value, -r value  reporter (console, simple) (default: "console") [$FERRET_LAB_REPORTER]
   --runtime value             url to remote Ferret runtime (http, https or bin) [$FERRET_LAB_RUNTIME]
   --runtime-param value       params for remote Ferret runtime (--runtime-param=headers:{"KeyId": "abcd"} --runtime-param=path:"/ferret" }) [$FERRET_LAB_RUNTIME_PARAM]
   --concurrency value         number of multiple tests to run at a time (default: 24) [$FERRET_LAB_CONCURRENCY]
   --dir value, -d value       file or directory to serve (./dir:8080 as default or ./dir:8080@name as named) [$FERRET_LAB_DIR]
   --param value, -p value     query parameter (--param=foo:"bar", --param=id:1) [$FERRET_LAB_PARAM]
   --wait value, -w value      waits for a 3rd party service by calling its endpoint (--wait http://127.0.0.1:9222/json/version, --wait postgres://locahost:5432/mydb) [$FERRET_LAB_WAIT]
   --wait-timeout value        wait timeout in seconds (default: 5) [$FERRET_LAB_WAIT_TIMEOUT]
   --wait-attempts value       wait attempts (default: 5) [$FERRET_LAB_WAIT_TRY]
   --help, -h                  show help (default: false)
   --version, -v               print the version (default: false)

```
