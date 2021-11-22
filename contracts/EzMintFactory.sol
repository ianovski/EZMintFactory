pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract EzMintFactory {
    using SafeMath for uint256;
    uint256 constant NULL = 0;
    struct Project {
        string name;
        string artist;
        string description;
        string website;
        string license;
        string staticImageLink;
        address projectAddress;
    }

    address public admin;
    uint256 public nextProjectId = 1;
    mapping(address => bool) public isWhitelisted;
    mapping(uint256 => Project) public projects;
    mapping(address => uint256) public projectAddressToProjectId;
    mapping(address => bool) public isProjectAddressUsed;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin");
        _;
    }

    modifier onlyWhitelisted() {
        require(isWhitelisted[msg.sender], "Only whitelisted");
        _;
    }

    constructor() public {
        admin = msg.sender;
        isWhitelisted[msg.sender] = true;
    }

    function addProject(string memory _projectName, string memory _projectArtist, string memory _projectDescription, string memory _website, string memory _license, string memory _staticImageLink, address _projectAddress) public onlyAdmin onlyWhitelisted {
        require(!isProjectAddressUsed[_projectAddress], "Project address can not be used more than once");
        uint256 projectId = nextProjectId;
        projects[projectId].name = _projectName;
        projects[projectId].artist = _projectArtist;
        projects[projectId].description = _projectDescription;
        projects[projectId].website = _website;
        projects[projectId].license = _license;
        projects[projectId].staticImageLink = _staticImageLink;
        projects[projectId].projectAddress = _projectAddress;
        projectAddressToProjectId[_projectAddress] = projectId;
        nextProjectId = nextProjectId.add(1);
        isProjectAddressUsed[_projectAddress] = true;
    }

    function updateProjectName(uint256 _projectId, string memory _projectName) onlyAdmin onlyWhitelisted public {
        require(_projectId != 0, "Project ID cannot be 0");
        projects[_projectId].name = _projectName;
    }

    function updateProjectArtistName(uint256 _projectId, string memory _projectArtistName) onlyAdmin onlyWhitelisted public {
        require(_projectId != 0, "Project ID cannot be 0");
        projects[_projectId].artist = _projectArtistName;
    }

    function updateProjectDescription(uint256 _projectId, string memory _projectDescription) onlyAdmin onlyWhitelisted public {
        require(_projectId != 0, "Project ID cannot be 0");
        projects[_projectId].description = _projectDescription;
    }

    function updateProjectLicense(uint256 _projectId, string memory _projectLicense) onlyAdmin onlyWhitelisted public {
        require(_projectId != 0, "Project ID cannot be 0");
        projects[_projectId].license = _projectLicense;
    }

    function updateProjectWebsite(uint256 _projectId, string memory _projectWebsite) onlyAdmin onlyWhitelisted public {
        require(_projectId != 0, "Project ID cannot be 0");
        projects[_projectId].website = _projectWebsite;
    }

    function updateProjectAddress(uint256 _projectId, address _newProjectAddress) onlyAdmin onlyWhitelisted public {
        require(!isProjectAddressUsed[_newProjectAddress], "Project address cannot be used more than once");
        require(_projectId != 0, "Project ID cannot be 0");
        address _prevAddress = projects[_projectId].projectAddress;
        projectAddressToProjectId[_prevAddress] = NULL;
        isProjectAddressUsed[_prevAddress] = false;
        projects[_projectId].projectAddress = _newProjectAddress;
        projectAddressToProjectId[_newProjectAddress] = _projectId;
        isProjectAddressUsed[_newProjectAddress] = true;
    }

    function updateStaticImageLink(uint256 _projectId, string memory _staticImageLink) onlyAdmin onlyWhitelisted public {
        require(_projectId != 0, "Project ID cannot be 0");
        projects[_projectId].staticImageLink = _staticImageLink;
    }

    function addWhitelisted(address _address) public onlyAdmin {
        isWhitelisted[_address] = true;
    }

    function removeWhitelisted(address _address) public onlyAdmin {
        isWhitelisted[_address] = false;
    }
}