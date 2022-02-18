From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 18 Feb 2022 10:01:32 +0000
Subject: [OpenRISC] [PATCH v2 00/18] clean up asm/uaccess.h,
 kill set_fs for good
In-Reply-To: <Yg77bNZfNhSk0bVQ@zeniv-ca.linux.org.uk>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
 <Yg77bNZfNhSk0bVQ@zeniv-ca.linux.org.uk>
Message-ID: <c5710bc5-0440-b828-d91e-6961081573af@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 18/02/2022 à 02:50, Al Viro a écrit :
> On Thu, Feb 17, 2022 at 07:20:11AM +0000, Christophe Leroy wrote:
> 
>> And we have also
>> user_access_begin()/user_read_access_begin()/user_write_access_begin()
>> which call access_ok() then do the real work. Could be made generic with
>> call to some arch specific __user_access_begin() and friends after the
>> access_ok() and eventually the might_fault().
> 
> Not a good idea, considering the fact that we do not want to invite
> uses of "faster" variants...

I'm not sure I understand your concern.

Today in powerpc we have:

	static __must_check inline bool
	user_read_access_begin(const void __user *ptr, size_t len)
	{
		if (unlikely(!access_ok(ptr, len)))
			return false;

		might_fault();

		allow_read_from_user(ptr, len);
		return true;
	}

We could instead have a generic

	static __must_check inline bool
	user_read_access_begin(const void __user *ptr, size_t len)
	{
		if (unlikely(!access_ok(ptr, len)))
			return false;

		might_fault();

		return arch_user_read_access_begin(ptr, len);
	}

And then a powerpc specific

	static __must_check __always_inline bool
	arch_user_read_access_begin(const void __user *ptr, size_t len)
	{
		allow_read_from_user(ptr, len);
		return true;
	}
	#define arch_user_read_access_begin arch_user_read_access_begin

And a generic fallback for arch_user_read_access_begin() that does 
nothing at all.

Do you mean that in that case people might be tempted to use 
arch_user_read_access_begin() instead of using user_read_access_begin() ?

If that's the case isn't it something we could verify via checkpatch.pl ?

Today it seems to be problematic that functions in asm/uaccess.h use 
access_ok(). Such an approach would allow to get rid of access_ok() use 
in architecture's uaccess.h

Christophe
