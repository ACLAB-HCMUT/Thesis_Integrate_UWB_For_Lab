using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class DeviceManager : MonoBehaviour
{
    public GameObject anchorPrefab;
    public GameObject tagPrefab;

    private Dictionary<string, GameObject> anchors = new Dictionary<string, GameObject>();
    private Dictionary<string, GameObject> tags = new Dictionary<string, GameObject>();

    public void ReceiveMessage(string message)
    {
        if (message.StartsWith("anchor,"))
        {
            string[] parts = message.Substring(7).Split(',');
            if (parts.Length == 4)
            {
                string anchorId = parts[0];
                float anchorX = float.Parse(parts[1]);
                float anchorY = float.Parse(parts[2]);
                float anchorZ = float.Parse(parts[3]);

                if (!anchors.ContainsKey(anchorId))
                {
                    GameObject anchorObj = Instantiate(anchorPrefab);
                    anchorObj.name = "Anchor_" + anchorId;
                    TextMeshPro anchorLabel = anchorObj.GetComponentInChildren<TextMeshPro>();
                    if (anchorLabel != null)
                    {
                        anchorLabel.text = anchorObj.name;
                    }
                    anchorObj.transform.position = new Vector3(anchorX, anchorY, anchorZ);
                    anchors[anchorId] = anchorObj;
                }
            }
        }
        else if (message.StartsWith("tag,"))
        {
            string[] parts = message.Substring(4).Split(',');
            if (parts.Length == 4)
            {
                string tagId = parts[0];
                float tagX = float.Parse(parts[1]);
                float tagY = float.Parse(parts[2]);
                float tagZ = float.Parse(parts[3]);

                if (!tags.ContainsKey(tagId))
                {
                    GameObject tagObj = Instantiate(tagPrefab);
                    tagObj.name = "Tag_" + tagId;
                    TextMeshPro tagLabel = tagObj.GetComponentInChildren<TextMeshPro>();
                    if (tagLabel != null)
                    {
                        tagLabel.text = tagObj.name;
                    }
                    tags[tagId] = tagObj;
                }

                tags[tagId].transform.position = new Vector3(tagX, tagY, tagZ);
            }
        }
    }

    public void RemoveTag(string tagId)
    {
        if (tags.ContainsKey(tagId))
        {
            Destroy(tags[tagId]);
            tags.Remove(tagId);
        }
    }
}
