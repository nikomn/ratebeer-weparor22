const BEERS = {};

const handleResponse = (beers) => {
    BEERS.list = beers;
    BEERS.show();
};

const createTableRow = (beer) => {
    const tr = document.createElement("tr");
    tr.classList.add("tablerow");
    const beername = tr.appendChild(document.createElement("td"));
    beername.innerHTML = beer.name;
    const style = tr.appendChild(document.createElement("td"));
    style.innerHTML = beer.style.name;
    const brewery = tr.appendChild(document.createElement("td"));
    brewery.innerHTML = beer.brewery.name;

    return tr;
};

BEERS.show = () => {
    document.querySelectorAll(".tablerow").forEach((el) => el.remove());
    const table = document.getElementById("beertable");

    BEERS.list.forEach((beer) => {
        const tr = createTableRow(beer);
        table.appendChild(tr);
    });
};

BEERS.sortByName = () => {
    BEERS.list.sort((a, b) => {
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BEERS.sortByStyle = () => {
    BEERS.list.sort((a, b) => {
        return a.style.name.toUpperCase().localeCompare(b.style.name.toUpperCase());
    });
};

BEERS.sortByBrewery = () => {
    BEERS.list.sort((a, b) => {
        return a.brewery.name
            .toUpperCase()
            .localeCompare(b.brewery.name.toUpperCase());
    });
};

const beers = () => {
    if (document.querySelectorAll("#beertable").length < 1) return;

    document.getElementById("name").addEventListener("click", (e) => {
        e.preventDefault;
        BEERS.sortByName();
        BEERS.show();
    });

    document.getElementById("style").addEventListener("click", (e) => {
        e.preventDefault;
        BEERS.sortByStyle();
        BEERS.show();
    });

    document.getElementById("brewery").addEventListener("click", (e) => {
        e.preventDefault;
        BEERS.sortByBrewery();
        BEERS.show();
    });

    fetch("beers.json")
        .then((response) => response.json())
        .then(handleResponse);

    // var request = new XMLHttpRequest();
    //
    // request.onload = handleResponse;
    //
    // request.open("get", "beers.json", true);
    // request.send();

};

const BREWERIES = {};

const createBreweryTableRow = (brewery) => {
    const tr = document.createElement("tr");
    tr.classList.add("tablerow");
    const breweryname = tr.appendChild(document.createElement("td"));
    breweryname.innerHTML = brewery.name;
    const breweryyear = tr.appendChild(document.createElement("td"));
    breweryyear.innerHTML = brewery.year;
    const brewerybeercount = tr.appendChild(document.createElement("td"));
    brewerybeercount.innerHTML = brewery.beers.length;
    const breweryactive = tr.appendChild(document.createElement("td"));
    breweryactive.innerHTML = brewery.active;

    return tr;
};

BREWERIES.show = () => {
    document.querySelectorAll(".tablerow").forEach((el) => el.remove());
    const table = document.getElementById("brewerytable");

    BREWERIES.list.forEach((brewery) => {
        const tr = createBreweryTableRow(brewery);
        table.appendChild(tr);
    });
};

BREWERIES.sortByName = () => {
    BREWERIES.list.sort((a, b) => {
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREWERIES.sortByYear = () => {
    BREWERIES.list.sort((a, b) => {
        return b.year - a.year;
    });
};

BREWERIES.sortByNumOfBeers = () => {
    BREWERIES.list.sort((a, b) => {
        return b.beers.length - a.beers.length;
    });
};

const handleBreweriesResponse = (breweries) => {
    BREWERIES.list = breweries;
    BREWERIES.show();
};

const breweries = () => {
    document.getElementById("name").addEventListener("click", (e) => {
        e.preventDefault;
        BREWERIES.sortByName();
        BREWERIES.show();
    });

    document.getElementById("year").addEventListener("click", (e) => {
        e.preventDefault;
        BREWERIES.sortByYear();
        BREWERIES.show();
    });

    document.getElementById("beer-count").addEventListener("click", (e) => {
        e.preventDefault;
        BREWERIES.sortByNumOfBeers();
        BREWERIES.show();
    });

    fetch("breweries.json")
        .then((response) => response.json())
        .then(handleBreweriesResponse);
};

export { beers, breweries };