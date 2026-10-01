Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FEC5304C2
	for <linux-openrisc@vger.kernel.org>; Thu,  1 Oct 2026 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790888770; cv=pass; b=YFiYbL7x1FPbd80zTtHOqcE+9+viLFIlyj1bA+BT6Ek8kFq3xTQ+oZ4oLCiyqOmvFD+bPAO+cyndmbgasFoELzam1Fh9Q01R11/e6YFTOq3gPryxn5KUeOdAhBYdZt81pM8AbWnCUyORtHM1WSrkw3bjJZ64UoYn3gHn/t3Bi0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790888770; c=relaxed/simple;
	bh=xN21QYy0yGgz2sHT1nXnC/21nVEwjhkQB04Hg4E+rW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gS1vU7pgRkPlQNV8/g8Hmv+5eixlw8nyt6qDEmTV5ldFfn0yYKOT05YGnCzKE9IzeUMTjuHDMo4yDTMPztYzHtdX/eIl663LxKVW2F9vw+xxtqZEyFZNjBEtMt842/uyeW3n4J9t/yZURdnlfZ0LMj4i8HHq83Za9SQnbaNucW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CAwV36pr; arc=pass smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CAwV36pr"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-88098db8dcdso3301713b3a.3
        for <linux-openrisc@vger.kernel.org>; Thu, 01 Oct 2026 14:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790888767; cv=none;
        d=google.com; s=arc-20260327;
        b=dYxobz9I1g4xzEwj8rukGg4U2PLWr3eRNlC38EpNZb0EsjmBwk9UFMOi0I1mCXyJ9E
         G9Lowvi8aSZ5vDHFIZWV5ocIrMqjMNuhmMwcSQy3rrXBlNS/Ccd7ercnyUgZQiwVlHGw
         oQvBriBca+dWzbx1xutj60GKYFTt7i2MwdmG7JiWrIdQK8vrEX5yHw8l+Wrz8JXmcykY
         ZB9PyWIQp6c855UXejlRwDbzgZ/aMM7nTsNvr9wNe5U10qo1nQGojkeWKtn7plD25aOu
         Qhu2IBJ4SdD/wheHv6lkx+QfKHx2VxnGCk4AJP0B3Qq+cljYM6UuR/3uSgNwgPGKCtSl
         oK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        fh=2myBgyGVoONbSFyWnQ9BX6ql2PHHrvvWleThjYzO21E=;
        b=TeJY0cNEnHOesE+2blayKvBQsCxIGYT4ozJpnpoObfz5UAcXx9DKeTCVP2rWsdwTGe
         9I05b/SibIkRXEHUdom+jZk5MBUawoT3Eil/GRJJNiXD8lP/+3i4/T0zYdALoK1CrQ+e
         jwscSN2K/P1s6+y/qVA3xWBBxFHjvauzmWXW7COqAPO2dbBRMZEoSmO80kWhx8RGP7BO
         +03LqGhAWUI3uHPfIp8WNU77Rix4F/RklRCDGNhz6P3RBZYaSB0ov9ev3t55YU87HFvI
         FdBygXzmAeXnO211NhRH1Lhx1c/rxbrqlHOlDlPMcI30xMcLI1LNEamULvHlsq+RTlZ0
         Kxjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790888767; x=1791493567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        b=CAwV36prXHOZw2NRE+aSACbPdDsBf2SHqbBYA6oNTHRxcIGcOyC/CJqkRH7LJRevOZ
         ClcJMU2t93f7XmqqwruK0c5ZXJiXQfI/+n+w9nHyb4EcEh0EZTu11pUBC9xzrVuOqKBT
         YsV75j7RrnJU55Z+JqH44vXWfdCbI4I+NCB8980IdTgu7vzPMxHvgU+uCw/+FxPpgY0h
         63X1M3w+g/hILuWVI8qWSFmlSwv2NKZwGdJ2DwWfYsxtFTA/lG+C3YADiA4myoIGj7HP
         Z1Ev8yhuTUNqN+BrgGDh8F6GLVD0gbmqkkcnf9FOFy5sLyuxAa1XjcNkIrhbHMfk8YG5
         z0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790888767; x=1791493567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        b=gmn38jyWe2fE+PsuFG43Tawr54oWLJQraoWIsuvV7AtqbZxLIcPF36yq2uWL006JtT
         abzSwI7MKiUkjgSYfBwsCXmvBcIGbJlKOsqcdA0gmGbqH6M/8mlph4e58dQYXYxP6VCG
         7d02eVXwHEBKr5YCEBsaPCq1q2ss0dy/7IRinX4wHVnGM5AzL+VHEnjyUKMvwyuc4I12
         WwqbazlZi3OgN9VWMULQNKFWKVy3l5fpR2U2D+ALVcYB89A+0PJlqkeG56/cb6PCzY6h
         lv2jzJL5gLcsN3dhun5UF+979wvqY++W1FROrCP9uLSrQaEKCX7SS0VBxpmm5ithcWZT
         Gx9w==
X-Forwarded-Encrypted: i=1; AKwUvBxtWYmbN0BRK+D4QdH2KrIgbUoCzDXvwc8bOV7/ua8FZrY/yKNTk/pxZ+dwsPLFFC7s1hr+XPPn89gdkDpmMQ==@vger.kernel.org
X-Gm-Message-State: AFuF++muJvtOUWfSviXiDYOPSG0GBLOUoxO8u4be84HcBT196y7uJzDE
	ZASls+bp3NsM4kGE5hQ6TISASg6iCi9vO1RtfpD2nqEOgwUQb0aGzwGUSLAUR54TK3fWi4KwzNV
	9zY5Y86YIBJxrW0VIINhW918rnWzr1+7/9oHNfwv0
X-Gm-Gg: AYBFou2QJqeFjnKeclINzKvN9zy1WPvqaxoRPemHWknAem8vrr0s7LWKOXjKKcHNKSs
	IA7FjA+K26QI8Qj6C9OAHUQPMQVsKit3QK4D5khzBgKxTgo3nPdbiOSyBfRfW0kuMU8nIM0OmRQ
	6JoG/+YTKZf2MrJ9AIE1zrJShrpHpHX5gr09QKhAoW/EBy6nZbVaF4lcPUgLhvCpJOiAFGxlT9C
	jUkXdGRhkchI4s4wZS1Vcy64O4W2Rh+oBID8Eugv+BElkrLt66Wuw68BzVdK6p0ErjCgFVXhHoX
	T6WP57RSGPeZvy2roFGFshE6zytCyvfTqq7Rf+Em1YZ8rKQGW8m8tiL1DC/uuDxF03/EImGwXyf
	RIaQ9G1ncB4Jh
X-Received: by 2002:a05:6a00:1254:b0:881:5dcb:400e with SMTP id
 d2e1a72fcca58-88af6d24f34mr727169b3a.56.1790888767004; Thu, 01 Oct 2026
 14:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com>
In-Reply-To: <cover.1790088067.git.rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Oct 2026 17:05:54 -0400
X-Gm-Features: AclHuK923qNeclwyxHc-N96rTW9f--kU_8IWc_3FVDcJfFTXqnWMr4asd_Mjppw
Message-ID: <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3), silently discarding the remaining two. This
> leads to the need for auxiliary records when audit-relevant
> data lands in the 5th or 6th argument of a syscall.
>
> This series extends the SYSCALL record to log all six arguments,
> by adding arguments a4 and a5 inline within the existing record.

Thanks Ricardo, this looks great!

There are a few things in some of the individual patches which I reply
to in a minute, but there are a couple of "global" things that I
wanted to mention:

* As pointed out by Sashiko, when you were converting all of the
arches, it looks like you missed alpha.  I took a quick look and it
appears that it should be a pretty straightforward conversion like
most of the others.

* We need to get ACKs from all the various arch maintainers.  Aside
from the parisc changes all of your arch specific patches are trivial
(and cleaner than the existing code IMO) so I don't expect anyone to
complain, but getting ACKs will likely take some time.  Even the
parisc patches aren't that bad, and arguably they fix a problem for
seccomp so that should make asking for ACKs easier :)

Since I expect chasing down all the various maintainers for ACKs will
take a little while, and I'd like to start getting this patchset some
basic testing, I'm going to merge it into dev-staging now.  While the
dev-staging branch doesn't feed into linux-next (this isn't likely to
land in the next merge window) it is one of the branches that gets
tested automatically and included in my kernel-secnext RPM builds.
This also means you won't need to worry about keeping this patchset
up-to-date with rebasing, as I rebase dev-staging as needed (it
intentionally isn't a stable branch).  Going forward, if there are any
minor changes to this patchset, e.g. a few line change in one of two
patches, please just send a fixup patchset based against
audit/dev-staging and I'll squash it into the relevant patch in the
series.  However, in the unlikely event that a major rewrite is
needed, just send a new patchset ... but I'll be very surprised if
that happens here :)

--=20
paul-moore.com
