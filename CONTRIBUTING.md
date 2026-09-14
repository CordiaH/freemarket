# Contributing to Freemarket

The rules here are stricter than in the main Haymarket repo. This code is
what stands between an organizer's conversation and whoever wants to read it,
and a subtle bug here fails silently — nobody notices encryption is broken
the way they notice a button not working.

## The cryptographic layer is human-only

**No agent-generated cryptographic code. No exceptions, including refactors,
including "just cleaning up."**

This covers key handling, group membership and commits, epoch advancement,
the message storage schema, and anything importing the MLS library. Elsewhere
in the repo — UI, layout, settings screens, tests — normal rules apply.

The reason is specific rather than superstitious: generated code is fluent,
and fluency reads as correctness in exactly the domain where correctness is
hardest to eyeball. A subtly wrong nonce handling routine looks identical to
a right one.

Related: **do not simplify the crypto layer.** Code there that looks redundant
usually is not. Zeroing that looks unnecessary, checks that look duplicated,
state transitions that look like ceremony — leave them. If something genuinely
is dead, open an issue rather than a PR.

## Never hand-roll

We use a maintained MLS implementation. Do not write a cipher, a KDF, a
ratchet, or a random number generator. Do not "improve" a primitive. If you
believe the library is wrong, that is an upstream issue and a conversation,
not a patch here.

## The deliberate omissions

These look like missing features and are decisions. Check
[THREAT-MODEL.md](THREAT-MODEL.md) before adding any of them back:

- No sender column on stored messages
- No presence or last-seen
- No persisted read receipts
- No server-side search or message index
- No history sync to newly added devices
- No cloud key backup

A PR adding any of these will be closed with a pointer to this list. If you
think one is genuinely wrong, argue it in an issue — that is a legitimate
conversation, just not one to have via a pull request.

## Claims and documents move together

If your change alters what we can promise, update
[LIMITATIONS.md](LIMITATIONS.md) and THREAT-MODEL.md **in the same PR**. Both
directions: a change that strengthens a guarantee should update them too.

Charter rule 6 says security claims must match the implementation exactly.
Documents drifting from code is how that rule gets broken without anyone
deciding to break it.

## Discuss before coding

Open an issue first for: anything touching MLS, schema changes, new
dependencies, changes to CSP or SRI, changes to the PWA caching strategy,
anything affecting what the server can observe.

Good PRs without discussion: UI and accessibility, tests, documentation,
localization, bug fixes with a reproduction.

## Dependencies

Stricter than the main repo. Every dependency in this bundle is code your
browser executes alongside your keys. Assume no. In your PR: the package, its
full transitive tree, what it does at runtime, why forty lines of our own code
would not do.

Anything that makes a network call gets refused by default.

## Pull requests

- What changed and why, two sentences
- Which THREAT-MODEL claims this touches, or "none"
- Whether the server can observe anything new
- New dependencies, or "none"
- What you tested, what you did not
- What you are unsure about

The last line is read first.

## Review

Merges to this repo require maintainer sign-off. Automated review may comment;
it cannot approve. That differs from the main repo on purpose.

## CLA

Required — see [CLA.md](CLA.md). Same terms as the main repo, same reason:
stewardship is intended to pass to a non-profit, and the agreement explicitly
forbids the project ever being made proprietary.

## Security issues

[SECURITY.md](SECURITY.md). Never the public issue tracker.
