defmodule PhoenixPollsWeb.PollsLiveTest do
  use PhoenixPollsWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixPolls.PollsterFixtures

  @create_attrs %{choices: [], description: "some description", invited: [], is_public: true, title: "some title", type: "some type"}
  @update_attrs %{choices: [], description: "some updated description", invited: [], is_public: false, title: "some updated title", type: "some updated type"}
  @invalid_attrs %{choices: [], description: nil, invited: [], is_public: false, title: nil, type: nil}

  defp create_polls(_) do
    polls = polls_fixture()
    %{polls: polls}
  end

  describe "Index" do
    setup [:create_polls]

    test "lists all polls", %{conn: conn, polls: polls} do
      {:ok, _index_live, html} = live(conn, Routes.polls_index_path(conn, :index))

      assert html =~ "Listing Polls"
      assert html =~ polls.description
    end

    test "saves new polls", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.polls_index_path(conn, :index))

      assert index_live |> element("a", "New Polls") |> render_click() =~
               "New Polls"

      assert_patch(index_live, Routes.polls_index_path(conn, :new))

      assert index_live
             |> form("#polls-form", polls: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#polls-form", polls: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.polls_index_path(conn, :index))

      assert html =~ "Polls created successfully"
      assert html =~ "some description"
    end

    test "updates polls in listing", %{conn: conn, polls: polls} do
      {:ok, index_live, _html} = live(conn, Routes.polls_index_path(conn, :index))

      assert index_live |> element("#polls-#{polls.id} a", "Edit") |> render_click() =~
               "Edit Polls"

      assert_patch(index_live, Routes.polls_index_path(conn, :edit, polls))

      assert index_live
             |> form("#polls-form", polls: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#polls-form", polls: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.polls_index_path(conn, :index))

      assert html =~ "Polls updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes polls in listing", %{conn: conn, polls: polls} do
      {:ok, index_live, _html} = live(conn, Routes.polls_index_path(conn, :index))

      assert index_live |> element("#polls-#{polls.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#polls-#{polls.id}")
    end
  end

  describe "Show" do
    setup [:create_polls]

    test "displays polls", %{conn: conn, polls: polls} do
      {:ok, _show_live, html} = live(conn, Routes.polls_show_path(conn, :show, polls))

      assert html =~ "Show Polls"
      assert html =~ polls.description
    end

    test "updates polls within modal", %{conn: conn, polls: polls} do
      {:ok, show_live, _html} = live(conn, Routes.polls_show_path(conn, :show, polls))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Polls"

      assert_patch(show_live, Routes.polls_show_path(conn, :edit, polls))

      assert show_live
             |> form("#polls-form", polls: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#polls-form", polls: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.polls_show_path(conn, :show, polls))

      assert html =~ "Polls updated successfully"
      assert html =~ "some updated description"
    end
  end
end
