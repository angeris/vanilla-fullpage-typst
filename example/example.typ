#import "../vanilla-fullpage.typ": template, abstract, paragraph

#show: template.with(
  title: "The Accidental Computer: Polynomial Commitments from Data Availability",
  authors: (
    (
      name: "Alex Evans",
      email: "aevans@baincapital.com"
    ),
    (
      name: "Guillermo Angeris",
      email: "gangeris@baincapital.com"
    ),
  ),
  date: "January 2025"
)

#abstract[
  In this paper, we present two simple variations of a data availability scheme
  that allow it to function as a multilinear polynomial commitment scheme over
  the data in a block. The first variation enables commitments over all of the
  block's data with zero prover overhead: the data availability construction
  simply serves both purposes. The second variation allows commitments over
  subsets of data with nonzero but still concretely small proving costs, since
  most work is already done during data encoding. Since, in many succinct proof
  systems, opening a polynomial commitment contributes significantly to prover
  costs, our construction enables the prover to reuse work already done by the
  data availability scheme, reducing---or wholly removing---work associated with
  the polynomial commitment scheme.
]

= Introduction
Blockchains, as their name suggests, are composed of an ordered list of blocks.
These blocks may include the data associated with financial transactions,
payments, or even social media posts and interactions. An important part of this
construction is that, as new blocks are added to this list, these new blocks
must satisfy some computational rules (or predicates) which ensure that the data
in the blocks is valid. For example, one (of potentially many) rules to be
enforced may be that no transaction in the block may transfer more money out of
an account than the account has available; _i.e._, that account balances may not
be negative. The list of such predicates is often called the _state transition
function_ of a blockchain: the predicates ensure that the latest state of the
blockchain, once it has been modified by the transactions of a block, is still a
valid end state.

#paragraph[Designs] In early blockchain designs, verifying the state transition
function required down- loading all transaction data for each block and
verifying the predicates for all downloaded blocks. As blockchains scale to
support more concurrent users, and therefore bigger blocks