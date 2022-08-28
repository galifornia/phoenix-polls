defmodule PhoenixPolls.PollsterTest do
  use PhoenixPolls.DataCase

  alias PhoenixPolls.Pollster

  describe "polls" do
    alias PhoenixPolls.Pollster.Polls

    import PhoenixPolls.PollsterFixtures

    @invalid_attrs %{choices: nil, description: nil, invited: nil, is_public: nil, title: nil, type: nil}

    test "list_polls/0 returns all polls" do
      polls = polls_fixture()
      assert Pollster.list_polls() == [polls]
    end

    test "get_polls!/1 returns the polls with given id" do
      polls = polls_fixture()
      assert Pollster.get_polls!(polls.id) == polls
    end

    test "create_polls/1 with valid data creates a polls" do
      valid_attrs = %{choices: [], description: "some description", invited: [], is_public: true, title: "some title", type: "some type"}

      assert {:ok, %Polls{} = polls} = Pollster.create_polls(valid_attrs)
      assert polls.choices == []
      assert polls.description == "some description"
      assert polls.invited == []
      assert polls.is_public == true
      assert polls.title == "some title"
      assert polls.type == "some type"
    end

    test "create_polls/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pollster.create_polls(@invalid_attrs)
    end

    test "update_polls/2 with valid data updates the polls" do
      polls = polls_fixture()
      update_attrs = %{choices: [], description: "some updated description", invited: [], is_public: false, title: "some updated title", type: "some updated type"}

      assert {:ok, %Polls{} = polls} = Pollster.update_polls(polls, update_attrs)
      assert polls.choices == []
      assert polls.description == "some updated description"
      assert polls.invited == []
      assert polls.is_public == false
      assert polls.title == "some updated title"
      assert polls.type == "some updated type"
    end

    test "update_polls/2 with invalid data returns error changeset" do
      polls = polls_fixture()
      assert {:error, %Ecto.Changeset{}} = Pollster.update_polls(polls, @invalid_attrs)
      assert polls == Pollster.get_polls!(polls.id)
    end

    test "delete_polls/1 deletes the polls" do
      polls = polls_fixture()
      assert {:ok, %Polls{}} = Pollster.delete_polls(polls)
      assert_raise Ecto.NoResultsError, fn -> Pollster.get_polls!(polls.id) end
    end

    test "change_polls/1 returns a polls changeset" do
      polls = polls_fixture()
      assert %Ecto.Changeset{} = Pollster.change_polls(polls)
    end
  end
end
