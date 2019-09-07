.PHONY: docs test link xcode linuxmain

test:
	swift test

lint:
	swiftlint

docs:
	jazzy --author "Simple Serialize" --author_url https://yeeth.af  --github_url https://github.com/yeeth/SimpleSerialize.swift
	rm -rf build/

xcode:
	swift package generate-xcodeproj

linuxmain:
	swift test --generate-linuxmain
