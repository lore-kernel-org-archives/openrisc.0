Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892B41519B9
	for <linux-openrisc@vger.kernel.org>; Thu,  5 Jun 2025 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749098075; cv=none; b=bnq1Bxpw5Smha2voK+pNejt9cKthqWlwIFD2Th64kV0T5s927dgrE6pS89PA4WyfQ85rhC8U6f4g8JsAOmN2gP9nkVVafhI33zvfvW5Ou38VbEfDdsqbNXemQ83+bXhjuKBquK0eWdkBEvv839/zQznVaCqqlQsCEMkJ476GV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749098075; c=relaxed/simple;
	bh=KlywLjCpoYLVKd1KHU/SoX6JWccv4fV2YByeX0jQmUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqUrMHiEm9AkDkedLRqpjbkjukQx3rMv4qVckd6hShQZxf9h46kVGgvI140SY7ZiH0KWF3UdxTvxDEEpBJgV+dU4ZMcD6AhN+JYl6UIpNkUGl03O89j+ti+xlt1Gkq8s05H1gcxsGDuZ9ytR9X/u5riHySBLhD5i2vEKpIuC0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j4BsejGm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ImT1PK+u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j4BsejGm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ImT1PK+u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j4BsejGm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ImT1PK+u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j4BsejGm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ImT1PK+u"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A10B211B8;
	Thu,  5 Jun 2025 04:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749098070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vhg/BSQkQq1b9VFsC44xsekkKzQTY9ISghkCrgC0U1c=;
	b=j4BsejGmsGIart99M2DYOoBQRNrxndzoLe0uY67fCL+DfJ0mKiVsqYYkqtXe6TUoSP4RCN
	OBqU5Xq6N3FWBLDUCzTXBXHfVUfBL//MihaCCFhZPq5VLy/Pp+YfVnxXur7lpmwbyF+R7S
	Oe2FhipjgZrzJoIZhn0/QQce+fyosNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749098070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vhg/BSQkQq1b9VFsC44xsekkKzQTY9ISghkCrgC0U1c=;
	b=ImT1PK+usPgp6EFG7l/JQOANOn7kVpf/m9BBX94NrCn59BYc5biRXmJyp34SnwjsK5hvbF
	ArQ1+zPywDQOLSDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749098070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vhg/BSQkQq1b9VFsC44xsekkKzQTY9ISghkCrgC0U1c=;
	b=j4BsejGmsGIart99M2DYOoBQRNrxndzoLe0uY67fCL+DfJ0mKiVsqYYkqtXe6TUoSP4RCN
	OBqU5Xq6N3FWBLDUCzTXBXHfVUfBL//MihaCCFhZPq5VLy/Pp+YfVnxXur7lpmwbyF+R7S
	Oe2FhipjgZrzJoIZhn0/QQce+fyosNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749098070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vhg/BSQkQq1b9VFsC44xsekkKzQTY9ISghkCrgC0U1c=;
	b=ImT1PK+usPgp6EFG7l/JQOANOn7kVpf/m9BBX94NrCn59BYc5biRXmJyp34SnwjsK5hvbF
	ArQ1+zPywDQOLSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22774137FE;
	Thu,  5 Jun 2025 04:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ViaJBVUeQWirdwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 05 Jun 2025 04:34:29 +0000
Date: Thu, 5 Jun 2025 06:34:23 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Jann Horn <jannh@google.com>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
Message-ID: <aEEeT2zyafbHzSyy@localhost.localdomain>
References: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-0.99)[-0.989];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,oracle.com,suse.cz,google.com,suse.com,linux.dev,xen0n.name,southpole.se,saunalahti.fi,gmail.com,sifive.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.linux.dev,vger.kernel.org,lists.infradead.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.29

On Wed, Jun 04, 2025 at 03:19:58PM +0100, Lorenzo Stoakes wrote:
> The walk_page_range_novma() function is rather confusing - it supports two
> modes, one used often, the other used only for debugging.
> 
> The first mode is the common case of traversal of kernel page tables, which
> is what nearly all callers use this for.
> 
> Secondly it provides an unusual debugging interface that allows for the
> traversal of page tables in a userland range of memory even for that memory
> which is not described by a VMA.
> 
> It is far from certain that such page tables should even exist, but perhaps
> this is precisely why it is useful as a debugging mechanism.
> 
> As a result, this is utilised by ptdump only. Historically, things were
> reversed - ptdump was the only user, and other parts of the kernel evolved
> to use the kernel page table walking here.
> 
> Since we have some complicated and confusing locking rules for the novma
> case, it makes sense to separate the two usages into their own functions.
> 
> Doing this also provide self-documentation as to the intent of the caller -
> are they doing something rather unusual or are they simply doing a standard
> kernel page table walk?
> 
> We therefore establish two separate functions - walk_page_range_debug() for
> this single usage, and walk_kernel_page_table_range() for general kernel
> page table walking.
> 
> We additionally make walk_page_range_debug() internal to mm.
> 
> Note that ptdump uses the precise same function for kernel walking as a
> convenience, so we permit this but make it very explicit by having
> walk_page_range_novma() invoke walk_kernel_page_table_range() in this case.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
