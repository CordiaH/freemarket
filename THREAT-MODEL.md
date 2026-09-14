# Threat model

Who Freemarket defends against, who it partially defends against, and who it
does not. Written for auditors and contributors; the member-facing version is
[LIMITATIONS.md](LIMITATIONS.md).

## What is being protected

The content of private organizing conversations, and — to the degree possible
— the fact of who is organizing with whom.

The underlying sensitivity: membership on Haymarket reveals political
affiliation. Association data here is not merely private, it is the kind of
information used to target people for harassment, employment retaliation, or
worse. Content confidentiality and association confidentiality are both in
scope, and we are considerably better at the first.

## Adversaries

| Adversary | Content | Metadata | Notes |
|---|:--:|:--:|---|
| Passive network observer | Protected | Protected | TLS plus E2EE |
| Scraper / bulk collector | Protected | Protected | Nothing readable is exposed |
| Curious or rogue operator (us) | Protected | **Not protected** | We route messages, so we see routing |
| Database breach | Protected | **Not protected** | Ciphertext plus membership and timing |
| Subpoena or legal order | Protected | **Not protected** | We produce what we hold; we hold little |
| Advertiser or data buyer | Protected | Protected | There is no path; none exists to sell |
| Compromised or coerced server serving modified JS | **Not protected** | Not protected | Section 1 of LIMITATIONS |
| Compromised member device | **Not protected** | Not protected | Out of scope for any messenger |
| Another participant repeating it | Not applicable | Not applicable | Social, not technical |
| Targeted state-level adversary | **Assume not protected** | Not protected | Direct members to Signal |

## Security properties we do claim

- **Confidentiality.** Message content is readable only by group members.
  Our servers store ciphertext and cannot decrypt it.
- **Forward secrecy.** Compromising current key material does not expose past
  epochs.
- **Post-compromise security.** After a compromised member is removed and the
  epoch advances, subsequent messages are protected again.
- **Sender authentication.** Messages are authenticated to a sending device
  inside the encrypted payload — which is also why the server has no sender
  column and cannot answer "everything X sent."
- **Membership integrity.** Group changes are authenticated commits, not
  server assertions. Clients surface membership changes rather than applying
  them silently.

## Security properties we explicitly do not claim

- **Metadata privacy.** Group membership, message timing, and approximate
  sizes are visible to us because delivery requires them.
- **Anonymity.** Freemarket accounts are tied to Haymarket accounts. This is
  not an anonymous messenger.
- **Code integrity against our own server.** See below.
- **Deniability.** We make no cryptographic deniability claim.
- **Availability under attack.** We are one person's infrastructure budget.

## The delivery problem, stated precisely

Browser-delivered cryptography means the entity serving the code is inside the
trust boundary. Freemarket cannot be more trustworthy than its origin server
on any given page load.

Mitigations, in order of how much they actually help:

1. **Installable PWA.** Code is not re-fetched every load, so a single
   malicious deploy does not automatically reach every user immediately.
2. **Separate origin.** `freemarket.haymarket.social`, isolated from the main
   app, so XSS in Haymarket cannot reach Freemarket's key material.
3. **Strict CSP and subresource integrity** on every asset.
4. **Published build hashes**, so a modified bundle is detectable by anyone
   who checks.

None of these make the server untrusted. They raise cost and increase the
chance that tampering is noticed. A browser extension with pinned code, or a
native client, would be a real improvement and is the right long-term
direction.

## Non-goals

- Competing with Signal on high-risk threat models. We link to it instead.
- Hiding the existence of Freemarket use from a network observer.
- Protecting against a member who chooses to share a conversation.
- Resisting a targeted, well-resourced adversary with legal reach over us.

## Review requirements

- MLS integration is human-written and human-reviewed. No agent-generated
  cryptographic code, ever, including refactors.
- Any change to key handling, group membership, epoch advancement, or the
  storage schema for messages requires explicit sign-off from the maintainer
  and cannot be merged on automated review alone.
- Any change that adds a column to a message or membership table must justify
  itself against this document.
- Any change that weakens a claim above requires updating LIMITATIONS.md in
  the same pull request.
