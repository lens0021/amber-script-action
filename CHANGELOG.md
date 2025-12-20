# Changelog

## [2.2.0](https://github.com/lens0021/amber-script-action/compare/v2.1.4...v2.2.0) (2025-12-20)


### Features

* Add output support via AMBER_SCRIPT_OUTPUT ([#90](https://github.com/lens0021/amber-script-action/issues/90)) ([d2bb361](https://github.com/lens0021/amber-script-action/commit/d2bb361384ae710486f2ee190dbbf73d733dc0af))

## [2.1.4](https://github.com/lens0021/amber-script-action/compare/v2.1.3...v2.1.4) (2025-12-20)


### Bug Fixes

* Raise errors from the user script if any ([#88](https://github.com/lens0021/amber-script-action/issues/88)) ([ccc3b73](https://github.com/lens0021/amber-script-action/commit/ccc3b733955490ae2a5fbf059af109901b4191f5))

## [2.1.3](https://github.com/lens0021/amber-script-action/compare/v2.1.2...v2.1.3) (2025-12-20)


### Bug Fixes

* **cache:** Use more detailed cache key to prevent conflict ([#83](https://github.com/lens0021/amber-script-action/issues/83)) ([99f3a18](https://github.com/lens0021/amber-script-action/commit/99f3a18fb86948ea07a79752a706a308a416640b))
* skip setup-amber on cache hit ([#84](https://github.com/lens0021/amber-script-action/issues/84)) ([1d684c9](https://github.com/lens0021/amber-script-action/commit/1d684c996ea164ca498cd31e4f6d3333764a5d9b))


### Reverts

* "fix: Propagate script exit code correctly ([#81](https://github.com/lens0021/amber-script-action/issues/81))" ([#86](https://github.com/lens0021/amber-script-action/issues/86)) ([518b6d3](https://github.com/lens0021/amber-script-action/commit/518b6d3f58acdfc5e51b32815e19f7aca68c5fd6))

## [2.1.2](https://github.com/lens0021/amber-script-action/compare/v2.1.1...v2.1.2) (2025-12-20)


### Bug Fixes

* Propagate script exit code correctly ([#81](https://github.com/lens0021/amber-script-action/issues/81)) ([bedaba2](https://github.com/lens0021/amber-script-action/commit/bedaba2bdd59a0474423d00d474c0d905d359855))

## [2.1.1](https://github.com/lens0021/amber-script-action/compare/v2.1.0...v2.1.1) (2025-12-20)


### Bug Fixes

* **cache-path:** Fix the bug the action fails when cache-path input used ([#77](https://github.com/lens0021/amber-script-action/issues/77)) ([c53f7e6](https://github.com/lens0021/amber-script-action/commit/c53f7e67b9aa67ede1ae2ddd710682e3525986c2))

## [2.1.0](https://github.com/lens0021/amber-script-action/compare/v2.0.4...v2.1.0) (2025-12-19)


### Features

* Improve caching strategy and use XDG-compliant paths ([#71](https://github.com/lens0021/amber-script-action/issues/71)) ([0a33b20](https://github.com/lens0021/amber-script-action/commit/0a33b204c46034582ccce529d12e4b6adc473db4))


### Bug Fixes

* Do not handle the failure of user-given script ([#73](https://github.com/lens0021/amber-script-action/issues/73)) ([f0ea6d6](https://github.com/lens0021/amber-script-action/commit/f0ea6d6ef370126b3257b3686954569b39a57c56))
* Remove unused variable and update outdated documentation ([#75](https://github.com/lens0021/amber-script-action/issues/75)) ([269b719](https://github.com/lens0021/amber-script-action/commit/269b7199e5be41b692837604b87ad770cc704dcf))

## [2.0.4](https://github.com/lens0021/amber-script-action/compare/v2.0.3...v2.0.4) (2025-12-11)


### Bug Fixes

* Typo in action.yaml from 'distame' to 'name' ([#60](https://github.com/lens0021/amber-script-action/issues/60)) ([1094c5a](https://github.com/lens0021/amber-script-action/commit/1094c5ae6f4a3a3b745dc0b573e1b9b3c1756558))

## [2.0.3](https://github.com/lens0021/amber-script-action/compare/v2.0.2...v2.0.3) (2025-12-11)


### Bug Fixes

* **internal:** Rename dest directory to dist ([#58](https://github.com/lens0021/amber-script-action/issues/58)) ([259c6fb](https://github.com/lens0021/amber-script-action/commit/259c6fb87831c5fe8cfca91a98e28c43a1824db1))

## [2.0.2](https://github.com/lens0021/amber-script-action/compare/v2.0.1...v2.0.2) (2025-12-11)


### Bug Fixes

* Bundle compiled bash script ([#55](https://github.com/lens0021/amber-script-action/issues/55)) ([9461610](https://github.com/lens0021/amber-script-action/commit/9461610e10a8edf4a44384d3e3a82b6a580e257b))

## [2.0.1](https://github.com/lens0021/amber-script-action/compare/v2.0.0...v2.0.1) (2025-12-08)


### Bug Fixes

* Add AMBER_SCRIPT_ prefix to environment variables ([#51](https://github.com/lens0021/amber-script-action/issues/51)) ([0dbcf86](https://github.com/lens0021/amber-script-action/commit/0dbcf865d136b147e15ced821467b8c180288213))

## [2.0.0](https://github.com/lens0021/amber-script-action/compare/v1.1.1...v2.0.0) (2025-12-05)


### ⚠ BREAKING CHANGES

* Update default amber-version to 0.5.1-alpha ([#48](https://github.com/lens0021/amber-script-action/issues/48))

### Features

* Add automated release management with release-please ([#36](https://github.com/lens0021/amber-script-action/issues/36)) ([2dad956](https://github.com/lens0021/amber-script-action/commit/2dad9566e83a4477c7cda15bdf058bd76069d725))
* Add semantic pull request validation workflow ([#35](https://github.com/lens0021/amber-script-action/issues/35)) ([4725552](https://github.com/lens0021/amber-script-action/commit/4725552dc2badd32c60359dd87020780726ab45d))
* Update default amber-version to 0.5.1-alpha ([#48](https://github.com/lens0021/amber-script-action/issues/48)) ([c792ee1](https://github.com/lens0021/amber-script-action/commit/c792ee1d8ce19037c28108f03c5c03d968c710fd))


### Bugfixes

* Address security vulnerabilities found by zizmor ([#41](https://github.com/lens0021/amber-script-action/issues/41)) ([bedb067](https://github.com/lens0021/amber-script-action/commit/bedb067ed45201913354a07a00660c2cce15f8af))
