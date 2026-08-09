# ParaWiki

Extensions to MediaWiki in their own repo, nicely wrapped up in a little docker container.

## Contents

Skins:

- TGUI

---

Extensions:

- ContributionScores
- MW-OAuth2Client
- SearchStats
- Tabs

## Development

All the extensions and skins are stored as submodules. To use this repo you **must** run `git submodule update --init` if you didn't clone with `--recurse-submodules`.

From there, just build this as you would any other docker project.

## License

This project is licensed under GPL2 as thats what the rest of Mediawiki is under. You can find a copy in `LICENSE.MD`.
