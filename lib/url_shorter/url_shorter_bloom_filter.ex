defmodule UrlShorter.UrlShorterBloomFilter do
  use GenServer

  alias UrlShorter.UrlShortenerContext

  # Server Callbacks
  
  @doc """
  GenServer.init/1 callback
  """
  def init(_state) do
    bloom_filter = UrlShortenerContext.list_urls()
    |> Enum.reduce(Bloomex.scalable(1000, 0.1, 0.1, 2, &Murmur.hash_x86_128/1), fn url, bf -> Bloomex.add(bf, url) end)
    
    IO.puts("**** BLOOM FILTER INITIALIZED ****")
    
    {:ok, bloom_filter}
  end
  
  def handle_call({:contains_url, url}, _from, bloom_filter) do
    {:reply, Bloomex.member?(bloom_filter, url), bloom_filter}
  end
  
  def handle_cast({:add_url, url}, bloom_filter) do
    IO.puts("#{url} ADDED TO BLOOM FILTER")

    {:noreply, Bloomex.add(bloom_filter, url)}
  end
  
  # ===================================================================================================
    
  # Client Interface
    
  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(bloom_filter \\ []) do
    IO.puts ("**** BLOOM FILTER GENSERVER STARTED... ****")

    GenServer.start_link(__MODULE__, bloom_filter, name: __MODULE__)
  end
    
  def contains_url?(url) do
    GenServer.call(__MODULE__, {:contains_url, url})
  end

  def add_url(url) do
    GenServer.cast(__MODULE__, {:add_url, url})
  end
end
