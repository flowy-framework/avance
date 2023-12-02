defmodule Avance.Core.Digests do
  @moduledoc """
  This module contains the business logic for Digests.
  """

  alias Avance.Queries.{DigestQuery, DigestProjectQuery}
  alias Avance.Schemas.{Digest, Project}

  defdelegate all, to: DigestQuery
  defdelegate get(id), to: DigestQuery
  defdelegate last(limit), to: DigestQuery
  defdelegate get!(id), to: DigestQuery
  defdelegate update!(mode, attrs), to: DigestQuery
  defdelegate update(mode, attrs), to: DigestQuery
  defdelegate delete(mode), to: DigestQuery
  defdelegate delete_all(), to: DigestQuery
  defdelegate create(attrs), to: DigestQuery
  defdelegate change(model, attrs \\ %{}), to: DigestQuery, as: :changeset

  @doc """
  Add a project to the digest
  """
  @spec add_project(Digest.t(), Project.t()) ::
          {:ok, DigestProject.t()} | {:error, Ecto.Changeset.t()}
  def add_project(%Digest{id: digest_id}, %Project{id: project_id}) do
    add_project(digest_id, project_id)
  end

  def add_project(digest_id, project_id) do
    DigestProjectQuery.create(%{digest_id: digest_id, project_id: project_id})
  end
end
