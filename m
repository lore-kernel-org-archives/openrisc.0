From: Stafford Horne <shorne@gmail.com>
Date: Wed, 17 Jun 2020 03:11:48 +0900
Subject: [OpenRISC] [PATCH 15/25] mm/openrisc: Use mm_fault_accounting()
In-Reply-To: <20200615221607.7764-16-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-16-peterx@redhat.com>
Message-ID: <20200616181148.GQ75760@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jun 15, 2020 at 06:15:57PM -0400, Peter Xu wrote:
> Use the new mm_fault_accounting() helper for page fault accounting.
> 
> Avoid doing page fault accounting multiple times if the page fault is retried.
> Also, the perf events for page faults will be accounted too when the config has
> CONFIG_PERF_EVENTS defined.
> 
> CC: Jonas Bonn <jonas@southpole.se>
> CC: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> CC: Stafford Horne <shorne@gmail.com>
> CC: openrisc at lists.librecores.org
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Stafford Horne <shorne@gmail.com>
