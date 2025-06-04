Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8DE2C327E
	for <linux-openrisc@vger.kernel.org>; Wed,  4 Jun 2025 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040027; cv=none; b=Kl2NonVSPbxpYSysB6tKwIz/DJbbq6Hw6qJYSVixFnvMkwJcWTf1mLimEMWwWA1MdFu+kworkvS1j3x/44uJk6QdTP20fuP6SDG2y5BzXFv2RGBXZG0aVSxQ4XOlzZgaRBjZiZaWIoWRoLcYJhtwlsCs9Q06PnHizhVbpdTNMM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040027; c=relaxed/simple;
	bh=oLP1nPL6gqLNtqwAV0glykOIgDFPZ4ZCJKTPFaQz4nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9o2jZ5zz+diIEDfi6C6EYV3Kv/u2xKB0qyrnCBUp4AcXEusYmus6fpSqoS1yF8qfe2bUQSXqOkUkcAAWtKqLKcO21V7XYEue2EM4Q7I3g4LdhYkb9cYRt/mSk/CFQDjMFbw4l48lkbKjt6q8avD+RNvbZkTOY0NgaK1a6HGjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rxOfor8O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=erBq3IwW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rxOfor8O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=erBq3IwW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rxOfor8O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="erBq3IwW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rxOfor8O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="erBq3IwW"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 718CC21F19;
	Wed,  4 Jun 2025 12:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749040024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oX0kM1so1dy8pP/ofGOK/RfWJhxo67WnVOlO1z5oEhM=;
	b=rxOfor8OgUrR/1UVw8dr5VVU+FzfPqBRAWxVCmbDEsIJM1zXswPslV66kNoIC3ssmLMxvT
	C0S3ZQ6LgBQQq0P1Q5C86zXAR7CnMlEHaIcqYcENiqH3XToL9tHQUqEcLxSreHOtP3Pj2Z
	7+u9Q7UZWAPlsZawSTC0W5/HShylQ5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749040024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oX0kM1so1dy8pP/ofGOK/RfWJhxo67WnVOlO1z5oEhM=;
	b=erBq3IwW3E0mI9V5yVPXBKmKuNfsiiBav06xnm8dhJ5XG7NNDAIO4bJ+yOWGT6i9itUrvs
	/nWBBe+8FMAgyjAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749040024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oX0kM1so1dy8pP/ofGOK/RfWJhxo67WnVOlO1z5oEhM=;
	b=rxOfor8OgUrR/1UVw8dr5VVU+FzfPqBRAWxVCmbDEsIJM1zXswPslV66kNoIC3ssmLMxvT
	C0S3ZQ6LgBQQq0P1Q5C86zXAR7CnMlEHaIcqYcENiqH3XToL9tHQUqEcLxSreHOtP3Pj2Z
	7+u9Q7UZWAPlsZawSTC0W5/HShylQ5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749040024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oX0kM1so1dy8pP/ofGOK/RfWJhxo67WnVOlO1z5oEhM=;
	b=erBq3IwW3E0mI9V5yVPXBKmKuNfsiiBav06xnm8dhJ5XG7NNDAIO4bJ+yOWGT6i9itUrvs
	/nWBBe+8FMAgyjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13BD913A63;
	Wed,  4 Jun 2025 12:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QI72AZc7QGgvTgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 04 Jun 2025 12:27:03 +0000
Date: Wed, 4 Jun 2025 14:26:57 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: [PATCH RESEND] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
Message-ID: <aEA7kW-D35lDzN2K@localhost.localdomain>
References: <20250603192213.182931-1-lorenzo.stoakes@oracle.com>
 <51ec4269-b132-4163-9cb5-766042a3769d@redhat.com>
 <aD_-qdg2OvKQIyRg@kernel.org>
 <d0df9d25-f6c7-46ce-9808-cc92855d6e9d@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0df9d25-f6c7-46ce-9808-cc92855d6e9d@lucifer.local>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,linux.dev,xen0n.name,southpole.se,saunalahti.fi,gmail.com,sifive.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.linux.dev,vger.kernel.org,lists.infradead.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, Jun 04, 2025 at 10:09:05AM +0100, Lorenzo Stoakes wrote:
> Nice idea to move to mm/internal.h also :) I like this...
> 
> Will fixup on respin

Dumb question but IIUC, walk_page_range_novma() will only be used by
ptdump from now on, so why not stick it into mm/ptdump.c, which is where
the only user of it lives?

-- 
Oscar Salvador
SUSE Labs
