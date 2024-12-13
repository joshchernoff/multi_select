defmodule MultiSelectExampleWeb.ExampleLiveTest do
  use MultiSelectExampleWeb.ConnCase

  import Phoenix.LiveViewTest
  import MultiSelectExample.ExamplesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_example(_) do
    example = example_fixture()
    %{example: example}
  end

  describe "Index" do
    setup [:create_example]

    test "lists all examples", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Listing Examples"
    end

    test "saves new example", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/")

      assert index_live |> element("a", "New Example") |> render_click() =~
               "New Example"

      assert_patch(index_live, ~p"//new")

      assert index_live
             |> form("#example-form", example: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#example-form", example: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/")

      html = render(index_live)
      assert html =~ "Example created successfully"
    end

    test "updates example in listing", %{conn: conn, example: example} do
      {:ok, index_live, _html} = live(conn, ~p"/")

      assert index_live |> element("#examples-#{example.id} a", "Edit") |> render_click() =~
               "Edit Example"

      assert_patch(index_live, ~p"//#{example}/edit")

      assert index_live
             |> form("#example-form", example: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#example-form", example: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/")

      html = render(index_live)
      assert html =~ "Example updated successfully"
    end

    test "deletes example in listing", %{conn: conn, example: example} do
      {:ok, index_live, _html} = live(conn, ~p"/")

      assert index_live |> element("#examples-#{example.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#examples-#{example.id}")
    end
  end

  describe "Show" do
    setup [:create_example]

    test "displays example", %{conn: conn, example: example} do
      {:ok, _show_live, html} = live(conn, ~p"//#{example}")

      assert html =~ "Show Example"
    end

    test "updates example within modal", %{conn: conn, example: example} do
      {:ok, show_live, _html} = live(conn, ~p"//#{example}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Example"

      assert_patch(show_live, ~p"//#{example}/show/edit")

      assert show_live
             |> form("#example-form", example: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#example-form", example: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"//#{example}")

      html = render(show_live)
      assert html =~ "Example updated successfully"
    end
  end
end
