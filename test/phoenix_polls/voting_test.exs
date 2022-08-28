defmodule PhoenixPolls.VotingTest do
  use PhoenixPolls.DataCase

  alias PhoenixPolls.Voting

  describe "votes" do
    alias PhoenixPolls.Voting.Vote

    import PhoenixPolls.VotingFixtures

    @invalid_attrs %{selection: nil}

    test "list_votes/0 returns all votes" do
      vote = vote_fixture()
      assert Voting.list_votes() == [vote]
    end

    test "get_vote!/1 returns the vote with given id" do
      vote = vote_fixture()
      assert Voting.get_vote!(vote.id) == vote
    end

    test "create_vote/1 with valid data creates a vote" do
      valid_attrs = %{selection: []}

      assert {:ok, %Vote{} = vote} = Voting.create_vote(valid_attrs)
      assert vote.selection == []
    end

    test "create_vote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Voting.create_vote(@invalid_attrs)
    end

    test "update_vote/2 with valid data updates the vote" do
      vote = vote_fixture()
      update_attrs = %{selection: []}

      assert {:ok, %Vote{} = vote} = Voting.update_vote(vote, update_attrs)
      assert vote.selection == []
    end

    test "update_vote/2 with invalid data returns error changeset" do
      vote = vote_fixture()
      assert {:error, %Ecto.Changeset{}} = Voting.update_vote(vote, @invalid_attrs)
      assert vote == Voting.get_vote!(vote.id)
    end

    test "delete_vote/1 deletes the vote" do
      vote = vote_fixture()
      assert {:ok, %Vote{}} = Voting.delete_vote(vote)
      assert_raise Ecto.NoResultsError, fn -> Voting.get_vote!(vote.id) end
    end

    test "change_vote/1 returns a vote changeset" do
      vote = vote_fixture()
      assert %Ecto.Changeset{} = Voting.change_vote(vote)
    end
  end
end
