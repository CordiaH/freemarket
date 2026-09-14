# What Freemarket does not protect you from

This page is published in the product, not only here. Charter rule 6 requires
that our security claims match our implementation exactly — that means saying
the uncomfortable parts out loud, in language a member can actually use to
make a decision.

Freemarket is end-to-end encrypted. That sentence is true and it is also not
the whole picture. Here is the rest.

---

## 1. We serve the code that does the encryption

Freemarket runs in your browser. Your browser gets its code from our server,
every time you load it. That means a compromised server — or one whose
operators are legally compelled, or one whose operators change their minds —
could serve a version that quietly sends your keys somewhere.

This is not a bug we can fix. It is the structural difference between a web
app and a signed native app like Signal, which ships a binary you can verify
once and keep.

**What we do about it:** Freemarket runs on its own origin, separate from
Haymarket, with a strict content security policy and subresource integrity on
every asset. We ship an installable PWA so the code is not re-fetched on every
load. We publish build hashes. None of this makes the server untrusted; it
narrows the window and makes tampering more likely to be noticed.

**What you should do about it:** if the threat you are worried about is a
state actor, a serious legal adversary, or anyone who could plausibly pressure
us specifically, use Signal for that conversation. We are not being modest.
This is the correct advice.

## 2. Encryption hides what you said, not who you talked to

We cannot read your messages. We can see — because delivering them requires it
— which devices are in which group, when messages move, and roughly how large
they are.

Metadata is usually what a subpoena actually asks for. "Who was in this group
in March" is a question our database can answer. "What did they say" is not.

We minimize this: no sender on stored messages, short retention enforced by a
sweeper, no presence, no read receipts, no search index. But we are not
claiming metadata privacy, because we cannot deliver it.

## 3. If your device is compromised, none of this helps

Encryption protects messages in transit and at rest on our servers. It does
nothing about malware on your laptop, someone reading over your shoulder, an
unlocked phone, or a device seized while logged in.

Use a device passcode. Lock your screen. This is boring advice and it is more
likely to matter than anything on this page.

## 4. Anyone in the conversation can repeat it

Screenshots exist. Other members can copy, forward, or simply tell someone.
End-to-end encryption means only conversation participants can read it — it
says nothing about what those participants do next.

Decide who is in a group as carefully as you would decide who is in a room.

## 5. Verify your contacts, or you are trusting us

MLS gives each device a key. When you start talking to someone, you are
trusting that the key we handed you is really theirs. A malicious server could
hand you a different one.

Freemarket surfaces key changes and provides out-of-band verification, but
**it only works if you use it.** If a key-change warning appears and you click
past it, the protection is gone. Compare verification codes in person or over
a channel you already trust, especially for anything sensitive.

## 6. New devices do not get old messages

Forward secrecy means past epochs stay closed. Add a new device and it starts
from that point — your history is not waiting for it. There is no cloud backup
of your keys, because a backup of your keys is a copy of your messages
somewhere you did not choose.

Lose all your devices and that history is gone. That is the cost of the
guarantee, and we would rather you know in advance than discover it.

## 7. We can be compelled

We are subject to legal process. We can be ordered to hand over what we have —
which is the metadata in section 2 — and, in some jurisdictions, potentially
to modify what we serve, which is section 1.

We hold as little as possible specifically so that compliance produces as
little as possible. We will publish a transparency report. We will say what we
can legally say and we will not pretend the possibility does not exist.

## 8. This has not been independently audited

As of this writing, no third party has audited Freemarket's cryptographic
implementation. We use a maintained MLS library rather than hand-rolled
cryptography, which removes the most common category of failure, but
integration bugs are real and we have not had ours found by someone whose job
it is to find them.

We will commission an audit when we can afford one and publish the result
whatever it says. Until then, treat this section as the honest state of play.

---

## The short version

Good for: everyday organizing conversation you do not want readable by us,
advertisers, scrapers, or whoever runs these servers in a decade.

Not sufficient for: anything where a well-resourced adversary is targeting you
specifically. Use Signal.

If any of this changes, this page changes with it, and we will say so in the
product rather than quietly editing a file.
